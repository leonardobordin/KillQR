import 'dart:async';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/app_providers.dart';
import '../../../core/database/app_database.dart';
import '../../../core/models/scan_models.dart';
import '../../../core/platform/external_action_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/document_scan_service.dart';
import '../data/zxing_scanner_adapter.dart';
import '../domain/content_parser.dart';

class ScannerPage extends ConsumerStatefulWidget {
  const ScannerPage({this.isActive = true, super.key});

  final bool isActive;

  @override
  ConsumerState<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends ConsumerState<ScannerPage> {
  static const _adapter = ZxingScannerAdapter();
  static const _documentScanner = DocumentScanService(decoder: _adapter);
  final Set<String> _recentContinuous = <String>{};
  bool _multiple = false;
  bool _openingResult = false;
  bool _importing = false;
  bool _documentLoadingVisible = false;
  DateTime? _documentLoadingStartedAt;
  Object? _cameraError;
  DateTime? _lastContinuousAt;
  int? _continuousSessionId;

  @override
  void didUpdateWidget(covariant ScannerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isActive && oldWidget.isActive) {
      _cameraError = null;
      unawaited(_finishContinuousSession());
    } else if (widget.isActive && !oldWidget.isActive) {
      _recentContinuous.clear();
      _lastContinuousAt = null;
    }
  }

  @override
  void dispose() {
    unawaited(_finishContinuousSession());
    super.dispose();
  }

  Future<void> _finishContinuousSession() async {
    final sessionId = _continuousSessionId;
    _continuousSessionId = null;
    if (sessionId == null) return;
    try {
      await ref
          .read(databaseProvider)
          .requireValue
          .finishContinuousSession(sessionId);
    } on Object {
      // The database may already be closing during app shutdown.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(appSettingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scanTitle),
        actions: [
          IconButton(
            tooltip: l10n.importDocument,
            onPressed: _importing ? null : _pickDocument,
            icon: _importing
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.file_open_outlined),
          ),
          IconButton(
            tooltip: l10n.continuousScan,
            onPressed: () => ref
                .read(appSettingsProvider)
                .setContinuousMode(!settings.continuousMode),
            icon: Icon(
              settings.continuousMode
                  ? Icons.playlist_add_check
                  : Icons.playlist_add,
            ),
          ),
        ],
      ),
      body: !widget.isActive
          ? Center(child: Text(l10n.cameraUnavailable))
          : Column(
              children: [
                if (_cameraError != null)
                  _CameraErrorBanner(
                    error: _cameraError!,
                    onRetry: () => setState(() => _cameraError = null),
                  ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _adapter.reader(
                        multiple: _multiple,
                        onResult: _handleResult,
                        onMultipleResults: _handleMultipleResults,
                        onError: (error) =>
                            setState(() => _cameraError = error),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        top: 16,
                        child: _ScannerHeader(
                          hint: l10n.scanHint,
                          multiple: _multiple,
                          onMultipleChanged: (value) =>
                              setState(() => _multiple = value),
                          semanticsLabel: l10n.multipleScan,
                        ),
                      ),
                      if (settings.continuousMode || settings.privateMode)
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: _ScannerStatus(
                            continuous: settings.continuousMode,
                            privateMode: settings.privateMode,
                            continuousLabel: l10n.continuousActive,
                            privateLabel: l10n.privateActive,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _pickDocument() async {
    if (_importing || !widget.isActive || !mounted) return;
    final l10n = AppLocalizations.of(context)!;
    XFile? file;
    try {
      file = await openFile(
        acceptedTypeGroups: DocumentScanService.acceptedTypeGroups(
          imageLabel: l10n.imageFiles,
          pdfLabel: l10n.pdfFiles,
          officeLabel: l10n.officeFiles,
        ),
      );
    } on Object {
      if (mounted) _showImportMessage(l10n.fileScanFailed, error: true);
      return;
    }
    if (file == null || !mounted) return;

    setState(() => _importing = true);
    _showDocumentLoading();
    try {
      // File imports are batch documents: always collect every code on the
      // selected file. The multiple-code switch remains dedicated to the
      // live camera flow, where it controls capture behavior and performance.
      final results = await _documentScanner.scan(file, multiple: true);
      await _hideDocumentLoading();
      if (!mounted) return;
      if (results.isEmpty) {
        _showImportMessage(l10n.codeNotFoundInFile, error: true);
      } else if (results.length == 1) {
        await _openResult(results.single);
      } else {
        await _openMultipleResults(results);
      }
    } on Object catch (error) {
      if (mounted) {
        await _hideDocumentLoading();
        _showImportMessage(_importErrorMessage(error, l10n), error: true);
      }
    } finally {
      await _hideDocumentLoading();
      if (mounted) setState(() => _importing = false);
    }
  }

  String _importErrorMessage(Object error, AppLocalizations l10n) {
    if (error is DocumentScanException) {
      switch (error.code) {
        case 'file_too_large':
          return l10n.fileTooLarge;
        case 'legacy_office':
          return l10n.legacyOfficeUnsupported;
        case 'unsupported_extension':
          return l10n.unsupportedFileType;
      }
    }
    return l10n.fileScanFailed;
  }

  void _showImportMessage(
    String message, {
    bool error = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }

  void _showDocumentLoading() {
    if (!mounted || _documentLoadingVisible) return;
    _documentLoadingVisible = true;
    _documentLoadingStartedAt = DateTime.now();
    final l10n = AppLocalizations.of(context)!;
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            content: Row(
              children: [
                const SizedBox.square(
                  dimension: 28,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(l10n.scanningFile)),
              ],
            ),
          ),
        ),
      ).whenComplete(() => _documentLoadingVisible = false),
    );
  }

  Future<void> _hideDocumentLoading() async {
    if (!_documentLoadingVisible || !mounted) return;
    final startedAt = _documentLoadingStartedAt;
    if (startedAt != null) {
      const minimumVisible = Duration(milliseconds: 350);
      final elapsed = DateTime.now().difference(startedAt);
      final remaining = minimumVisible - elapsed;
      if (remaining > Duration.zero) await Future<void>.delayed(remaining);
    }
    if (!_documentLoadingVisible || !mounted) return;
    _documentLoadingVisible = false;
    _documentLoadingStartedAt = null;
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _handleResult(BarcodeScanResult result) async {
    final settings = ref.read(appSettingsProvider);
    if (settings.continuousMode) {
      await _handleContinuous(result, settings);
      return;
    }
    await _openResult(result);
  }

  Future<void> _openResult(BarcodeScanResult result) async {
    if (_openingResult || !mounted) return;
    _openingResult = true;
    try {
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(builder: (_) => ScanResultPage(result: result)),
      );
    } finally {
      _openingResult = false;
    }
  }

  Future<void> _handleMultipleResults(List<BarcodeScanResult> results) async {
    final settings = ref.read(appSettingsProvider);
    if (settings.continuousMode) {
      for (final result in results) {
        await _handleContinuous(result, settings);
      }
      return;
    }
    await _openMultipleResults(results);
  }

  Future<void> _openMultipleResults(List<BarcodeScanResult> results) async {
    if (!mounted || _openingResult) return;
    _openingResult = true;
    try {
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => MultipleResultsPage(results: results),
        ),
      );
    } finally {
      _openingResult = false;
    }
  }

  Future<void> _handleContinuous(
    BarcodeScanResult result,
    AppSettingsController settings,
  ) async {
    final now = DateTime.now();
    if (_lastContinuousAt != null &&
        now.difference(_lastContinuousAt!) < settings.debounce) {
      return;
    }
    final key = '${result.formatKey}|${result.rawValue}';
    if (!_recentContinuous.add(key)) return;
    _lastContinuousAt = now;
    if (!settings.privateMode && settings.saveAutomatically) {
      final database = ref.read(databaseProvider).requireValue;
      _continuousSessionId ??= await database.createContinuousSession();
      final parsed = const ContentParser().parse(result.rawValue);
      await database.insertScan(
        rawValue: result.rawValue,
        formatKey: result.formatKey,
        contentType: parsed.type.name,
        source: ScanSource.continuous.name,
        createdAt: result.capturedAt ?? DateTime.now().toUtc(),
        parserVersion: ContentParser.parserVersion,
        batchSessionId: _continuousSessionId,
      );
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.rawValue),
        duration: const Duration(milliseconds: 900),
      ),
    );
    Timer(settings.debounce, () => _recentContinuous.remove(key));
  }
}

class _ScannerHeader extends StatelessWidget {
  const _ScannerHeader({
    required this.hint,
    required this.multiple,
    required this.onMultipleChanged,
    required this.semanticsLabel,
  });

  final String hint;
  final bool multiple;
  final ValueChanged<bool> onMultipleChanged;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.center_focus_strong, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(hint, style: const TextStyle(color: Colors.white)),
            ),
            Semantics(
              label: semanticsLabel,
              child: Switch(
                value: multiple,
                onChanged: onMultipleChanged,
                activeThumbColor: colorScheme.onPrimary,
                activeTrackColor: colorScheme.primary,
                inactiveThumbColor: colorScheme.onSurfaceVariant,
                inactiveTrackColor: colorScheme.surfaceContainerHighest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerStatus extends StatelessWidget {
  const _ScannerStatus({
    required this.continuous,
    required this.privateMode,
    required this.continuousLabel,
    required this.privateLabel,
  });

  final bool continuous;
  final bool privateMode;
  final String continuousLabel;
  final String privateLabel;

  @override
  Widget build(BuildContext context) {
    if (!continuous && !privateMode) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      children: [
        if (continuous)
          Chip(
            avatar: const Icon(Icons.repeat, size: 16),
            label: Text(continuousLabel),
          ),
        if (privateMode)
          Chip(
            avatar: const Icon(Icons.visibility_off, size: 16),
            label: Text(privateLabel),
          ),
      ],
    );
  }
}

class _CameraErrorBanner extends StatelessWidget {
  const _CameraErrorBanner({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MaterialBanner(
      content: Text('${l10n.cameraUnavailable}: $error'),
      leading: const Icon(Icons.videocam_off_outlined),
      actions: [TextButton(onPressed: onRetry, child: Text(l10n.retry))],
    );
  }
}

class MultipleResultsPage extends StatelessWidget {
  const MultipleResultsPage({required this.results, super.key});

  final List<BarcodeScanResult> results;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text('${results.length} ${l10n.scanner}')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final result = results[index];
          return Card(
            child: ListTile(
              title: Text(
                result.rawValue,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(result.formatLabel),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push<void>(
                MaterialPageRoute<void>(
                  builder: (_) => ScanResultPage(result: result),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScanResultPage extends ConsumerStatefulWidget {
  const ScanResultPage({required this.result, this.existingId, super.key});

  final BarcodeScanResult result;
  final int? existingId;

  @override
  ConsumerState<ScanResultPage> createState() => _ScanResultPageState();
}

class _ScanResultPageState extends ConsumerState<ScanResultPage> {
  static const _parser = ContentParser();
  final _noteController = TextEditingController();
  final _tagsController = TextEditingController();
  bool _saved = false;
  bool _saving = false;
  bool _favorite = false;
  List<String> _tagNames = const <String>[];

  ParsedContent get parsed => _parser.parse(widget.result.rawValue);

  @override
  void initState() {
    super.initState();
    final settings = ref.read(appSettingsProvider);
    if (widget.existingId == null &&
        settings.saveAutomatically &&
        !settings.privateMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _save());
    } else if (widget.existingId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadExisting());
    }
  }

  Future<void> _loadExisting() async {
    final id = widget.existingId;
    if (id == null) return;
    final database = ref.read(databaseProvider).requireValue;
    final record = await database.getScan(id);
    final tags = await database.getTagsForScan(id);
    if (!mounted || record == null) return;
    _noteController.text = record.note ?? '';
    setState(() {
      _favorite = record.isFavorite;
      _tagNames = tags.map((tag) => tag.name).toList(growable: false);
      _saved = true;
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final content = parsed;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.details),
        actions: [
          IconButton(
            tooltip: l10n.copy,
            onPressed: _copy,
            icon: const Icon(Icons.copy_outlined),
          ),
          IconButton(
            tooltip: l10n.share,
            onPressed: _share,
            icon: const Icon(Icons.share_outlined),
          ),
          IconButton(
            tooltip: l10n.favorite,
            onPressed: _toggleFavorite,
            icon: Icon(
              _favorite ? Icons.star : Icons.star_border,
              color: _favorite ? Colors.amber : null,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _TypeHeader(content: content),
          const SizedBox(height: 16),
          _DetailCard(
            title: l10n.value,
            child: SelectableText(
              widget.result.rawValue,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(fontFamily: 'monospace', height: 1.45),
            ),
          ),
          const SizedBox(height: 12),
          _MetadataCard(result: widget.result, content: content),
          if (content.fields.isNotEmpty) ...[
            const SizedBox(height: 12),
            _DetailCard(
              title: l10n.details,
              child: Column(
                children: content.fields.entries
                    .map(
                      (entry) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(entry.key),
                        subtitle: Text(entry.value),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          if (content.warnings.isNotEmpty) ...[
            const SizedBox(height: 12),
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: ListTile(
                leading: const Icon(Icons.warning_amber_outlined),
                title: Text(l10n.warning),
                subtitle: Text(l10n.parserWarning),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Text(l10n.actions, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (content.actions.isEmpty && content.type != ContentType.product)
            Text(
              l10n.noAppFound,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ...content.actions.map(
            (action) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FilledButton.tonalIcon(
                onPressed: () => _execute(action),
                icon: Icon(_actionIcon(action.type)),
                label: Text(_actionLabel(action.labelKey, l10n)),
              ),
            ),
          ),
          if (content.type == ContentType.product)
            _buildProductActions(content.original, l10n),
          const SizedBox(height: 8),
          TextField(
            controller: _noteController,
            minLines: 2,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: l10n.note,
              hintText: l10n.addNote,
            ),
          ),
          const SizedBox(height: 12),
          _DetailCard(
            title: l10n.tags,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._tagNames.map(
                  (tag) => InputChip(
                    label: Text(tag),
                    onDeleted: () => _removeTag(tag),
                  ),
                ),
                ActionChip(
                  avatar: const Icon(Icons.add, size: 18),
                  label: Text(l10n.addTag),
                  onPressed: _editTags,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: Icon(_saved ? Icons.check : Icons.bookmark_add_outlined),
            label: Text(_saved ? l10n.saved : l10n.save),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (_saving || !mounted) return;
    final settings = ref.read(appSettingsProvider);
    if (settings.privateMode && widget.existingId == null) {
      setState(() => _saved = false);
      return;
    }
    setState(() => _saving = true);
    final db = ref.read(databaseProvider).requireValue;
    if (widget.existingId != null) {
      await db.updateScan(
        id: widget.existingId!,
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        isFavorite: _favorite,
      );
      await db.setTagsForScan(widget.existingId!, _tagNames);
    } else {
      final id = await db.insertScan(
        rawValue: widget.result.rawValue,
        formatKey: widget.result.formatKey,
        contentType: parsed.type.name,
        source: widget.result.source.name,
        createdAt: widget.result.capturedAt ?? DateTime.now().toUtc(),
        note: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        parserVersion: ContentParser.parserVersion,
        isFavorite: _favorite,
      );
      await db.setTagsForScan(id, _tagNames);
    }
    if (mounted) {
      setState(() {
        _saved = true;
        _saving = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    setState(() => _favorite = !_favorite);
    if (widget.existingId != null) {
      await ref
          .read(databaseProvider)
          .requireValue
          .updateScan(id: widget.existingId!, isFavorite: _favorite);
    }
  }

  Future<void> _removeTag(String tag) async {
    setState(() {
      _tagNames = _tagNames
          .where((value) => value != tag)
          .toList(growable: false);
    });
    if (widget.existingId != null) {
      await ref
          .read(databaseProvider)
          .requireValue
          .setTagsForScan(widget.existingId!, _tagNames);
    }
  }

  Future<void> _editTags() async {
    final l10n = AppLocalizations.of(context)!;
    _tagsController.text = _tagNames.join(', ');
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.tags),
        content: TextField(
          controller: _tagsController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: l10n.tagHint,
            helperText: l10n.tagHint,
          ),
          textInputAction: TextInputAction.done,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, _tagsController.text),
            child: Text(l10n.saveTags),
          ),
        ],
      ),
    );
    if (value == null || !mounted) return;
    final names = value
        .split(RegExp(r'[,\n]'))
        .map((tag) => tag.trim().replaceAll(RegExp(r'\s+'), ' '))
        .where((tag) => tag.isNotEmpty)
        .take(50)
        .toSet()
        .toList(growable: false);
    setState(() => _tagNames = names);
    if (widget.existingId != null) {
      await ref
          .read(databaseProvider)
          .requireValue
          .setTagsForScan(widget.existingId!, names);
    }
  }

  Widget _buildProductActions(String code, AppLocalizations l10n) {
    final database = ref.read(databaseProvider).requireValue;
    return FutureBuilder<List<SearchEngine>>(
      future: database.getSearchEngines(),
      builder: (context, snapshot) {
        final engines =
            snapshot.data?.where((engine) => engine.isActive) ??
            const <SearchEngine>[];
        final actions = engines.map((engine) {
          final encoded = Uri.encodeQueryComponent(code);
          return ExternalAction(
            type: ExternalActionType.productSearch,
            labelKey: 'searchProduct',
            payload: <String, String>{
              'uri': engine.template.replaceAll('{CODE}', encoded),
            },
          );
        });
        if (actions.isEmpty) {
          return Text(
            l10n.noAppFound,
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }
        return Column(
          children: actions
              .map(
                (action) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: FilledButton.tonalIcon(
                    onPressed: () => _execute(action),
                    icon: Icon(_actionIcon(action.type)),
                    label: Text(_actionLabel(action.labelKey, l10n)),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.result.rawValue));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.copied)),
    );
  }

  Future<void> _share() async {
    await SharePlus.instance.share(ShareParams(text: widget.result.rawValue));
  }

  Future<void> _execute(ExternalAction action) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_actionLabel(action.labelKey, l10n)),
        content: Text(l10n.confirmExternalAction),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.openSettings),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    final opened = await const ExternalActionService().execute(action);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.noAppFound)));
    }
  }

  String _actionLabel(String key, AppLocalizations l10n) {
    switch (key) {
      case 'actionOpen':
        return l10n.actionOpen;
      case 'actionCall':
        return l10n.actionCall;
      case 'actionSendSms':
        return l10n.actionSendSms;
      case 'actionSendEmail':
        return l10n.actionSendEmail;
      case 'actionOpenMap':
        return l10n.actionOpenMap;
      case 'actionSaveContact':
        return l10n.actionSaveContact;
      case 'actionSaveEvent':
        return l10n.actionSaveEvent;
      case 'actionWifiSettings':
        return l10n.actionWifiSettings;
      case 'searchProduct':
        return l10n.searchProduct;
      default:
        return l10n.actions;
    }
  }

  IconData _actionIcon(ExternalActionType type) {
    switch (type) {
      case ExternalActionType.openUrl:
        return Icons.open_in_new;
      case ExternalActionType.dial:
        return Icons.call_outlined;
      case ExternalActionType.composeSms:
        return Icons.sms_outlined;
      case ExternalActionType.composeEmail:
        return Icons.email_outlined;
      case ExternalActionType.openGeo:
        return Icons.map_outlined;
      case ExternalActionType.insertContact:
        return Icons.person_add_outlined;
      case ExternalActionType.insertEvent:
        return Icons.event_outlined;
      case ExternalActionType.openWifiSettings:
        return Icons.wifi;
      case ExternalActionType.productSearch:
        return Icons.search;
    }
  }
}

class _TypeHeader extends StatelessWidget {
  const _TypeHeader({required this.content});

  final ParsedContent content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 24, child: Icon(_iconFor(content.type))),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            _contentTypeName(context, content.type),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }

  static IconData _iconFor(ContentType type) {
    switch (type) {
      case ContentType.url:
        return Icons.link;
      case ContentType.phone:
        return Icons.phone;
      case ContentType.sms:
        return Icons.sms;
      case ContentType.email:
        return Icons.email;
      case ContentType.wifi:
        return Icons.wifi;
      case ContentType.contact:
        return Icons.person;
      case ContentType.geo:
        return Icons.location_on;
      case ContentType.event:
        return Icons.event;
      case ContentType.product:
        return Icons.shopping_bag;
      case ContentType.text:
      case ContentType.unknown:
        return Icons.notes;
    }
  }
}

String _contentTypeName(BuildContext context, ContentType type) {
  final l10n = AppLocalizations.of(context)!;
  switch (type) {
    case ContentType.text:
      return l10n.typeText;
    case ContentType.url:
      return l10n.typeUrl;
    case ContentType.phone:
      return l10n.typePhone;
    case ContentType.sms:
      return l10n.typeSms;
    case ContentType.email:
      return l10n.typeEmail;
    case ContentType.wifi:
      return l10n.typeWifi;
    case ContentType.contact:
      return l10n.typeContact;
    case ContentType.geo:
      return l10n.typeGeo;
    case ContentType.event:
      return l10n.typeEvent;
    case ContentType.product:
      return l10n.typeProduct;
    case ContentType.unknown:
      return l10n.typeUnknown;
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _MetadataCard extends StatelessWidget {
  const _MetadataCard({required this.result, required this.content});

  final BarcodeScanResult result;
  final ParsedContent content;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.qr_code_2),
            title: Text(l10n.format),
            subtitle: Text(result.formatLabel),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: Text(l10n.source),
            subtitle: Text(_sourceName(context, result.source)),
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: Text(l10n.type),
            subtitle: Text(_contentTypeName(context, content.type)),
          ),
        ],
      ),
    );
  }
}

String _sourceName(BuildContext context, ScanSource source) {
  final l10n = AppLocalizations.of(context)!;
  switch (source) {
    case ScanSource.camera:
      return l10n.sourceCamera;
    case ScanSource.image:
      return l10n.sourceImage;
    case ScanSource.continuous:
      return l10n.sourceContinuous;
    case ScanSource.imported:
      return l10n.sourceImported;
    case ScanSource.generated:
      return l10n.sourceGenerated;
  }
}
