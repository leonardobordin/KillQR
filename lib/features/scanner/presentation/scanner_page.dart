import 'dart:async';

import 'package:camera/camera.dart' as camera;
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
  camera.CameraController? _cameraController;
  camera.CameraLensDirection _lensDirection = camera.CameraLensDirection.back;
  double _scanAreaPercent = 0.5;
  double _zoom = 1;
  double _minZoom = 1;
  double _maxZoom = 1;
  bool _flashBusy = false;
  bool _cameraSwitching = false;

  @override
  void didUpdateWidget(covariant ScannerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isActive && oldWidget.isActive) {
      _cameraError = null;
      _cameraController = null;
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
        actions: _buildTopActions(context, settings, l10n),
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
                        lensDirection: _lensDirection,
                        cropPercent: _scanAreaPercent,
                        borderColor: Theme.of(context).colorScheme.primary,
                        onControllerCreated: _handleControllerCreated,
                        onResult: _handleResult,
                        onMultipleResults: _handleMultipleResults,
                        onError: (error) =>
                            setState(() => _cameraError = error),
                      ),
                      Positioned(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        child: _ScannerBottomControls(
                          scanAreaPercent: _scanAreaPercent,
                          zoom: _zoom,
                          minZoom: _minZoom,
                          maxZoom: _maxZoom,
                          multiple: _multiple,
                          onScanAreaChanged: (value) =>
                              setState(() => _scanAreaPercent = value),
                          onZoomChanged: _setZoom,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _buildTopActions(
    BuildContext context,
    AppSettingsController settings,
    AppLocalizations l10n,
  ) {
    final width = MediaQuery.sizeOf(context).width;
    final flashAction = _scannerAction(
      context,
      tooltip: l10n.flashlight,
      icon: _cameraController?.value.flashMode == camera.FlashMode.torch
          ? Icons.flash_on
          : Icons.flash_off,
      onPressed: _cameraController == null || _flashBusy ? null : _toggleFlash,
      busy: _flashBusy,
    );
    final cameraAction = _scannerAction(
      context,
      tooltip: l10n.switchCamera,
      icon: Icons.flip_camera_android_outlined,
      onPressed: _cameraController == null || _cameraSwitching
          ? null
          : _switchCamera,
      busy: _cameraSwitching,
    );
    final documentAction = _scannerAction(
      context,
      tooltip: l10n.importDocument,
      icon: Icons.file_open_outlined,
      onPressed: _importing ? null : _pickDocument,
      busy: _importing,
    );
    final continuousAction = _scannerAction(
      context,
      tooltip: l10n.continuousScan,
      icon: settings.continuousMode
          ? Icons.playlist_add_check
          : Icons.playlist_add,
      active: settings.continuousMode,
      onPressed: () => unawaited(_toggleContinuousMode()),
    );
    final multipleAction = _scannerAction(
      context,
      tooltip: l10n.multipleScan,
      icon: _multiple ? Icons.select_all : Icons.qr_code_2,
      active: _multiple,
      onPressed: () => unawaited(_toggleMultiple()),
    );

    if (width < 360) {
      return <Widget>[
        flashAction,
        cameraAction,
        _buildOverflowMenu(
          context,
          settings,
          l10n,
          includeDocument: true,
          includeContinuous: true,
          includeMultiple: true,
        ),
      ];
    }
    if (width < 460) {
      return <Widget>[
        flashAction,
        cameraAction,
        documentAction,
        _buildOverflowMenu(
          context,
          settings,
          l10n,
          includeDocument: false,
          includeContinuous: true,
          includeMultiple: true,
        ),
      ];
    }
    return <Widget>[
      flashAction,
      cameraAction,
      documentAction,
      continuousAction,
      multipleAction,
    ];
  }

  Widget _scannerAction(
    BuildContext context, {
    required String tooltip,
    required IconData icon,
    required VoidCallback? onPressed,
    bool active = false,
    bool busy = false,
  }) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      style: active
          ? IconButton.styleFrom(
              backgroundColor: colors.primaryContainer,
              foregroundColor: colors.onPrimaryContainer,
            )
          : null,
      icon: busy
          ? const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon),
    );
  }

  Widget _buildOverflowMenu(
    BuildContext context,
    AppSettingsController settings,
    AppLocalizations l10n, {
    required bool includeDocument,
    required bool includeContinuous,
    required bool includeMultiple,
  }) {
    final entries = <_ScannerMenuAction>[
      if (includeDocument) _ScannerMenuAction.document,
      if (includeContinuous) _ScannerMenuAction.continuous,
      if (includeMultiple) _ScannerMenuAction.multiple,
    ];
    return PopupMenuButton<_ScannerMenuAction>(
      tooltip: l10n.moreScannerActions,
      onSelected: _onScannerMenuActionSelected,
      itemBuilder: (context) => entries.map((action) {
        final item = _menuItemData(action, settings, l10n);
        final colors = Theme.of(context).colorScheme;
        return PopupMenuItem<_ScannerMenuAction>(
          value: action,
          height: 68,
          child: SizedBox(
            width: 250,
            child: Row(
              children: [
                Icon(item.icon, color: item.active ? colors.primary : null),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        item.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      icon: const Icon(Icons.more_vert),
    );
  }

  _ScannerMenuItemData _menuItemData(
    _ScannerMenuAction action,
    AppSettingsController settings,
    AppLocalizations l10n,
  ) {
    switch (action) {
      case _ScannerMenuAction.document:
        return _ScannerMenuItemData(
          icon: Icons.file_open_outlined,
          title: l10n.importDocument,
          description: l10n.importDocumentDescription,
        );
      case _ScannerMenuAction.continuous:
        return _ScannerMenuItemData(
          icon: settings.continuousMode
              ? Icons.playlist_add_check
              : Icons.playlist_add,
          title: l10n.continuousScan,
          description: l10n.continuousScanDescription,
          active: settings.continuousMode,
        );
      case _ScannerMenuAction.multiple:
        return _ScannerMenuItemData(
          icon: _multiple ? Icons.select_all : Icons.qr_code_2,
          title: l10n.multipleScan,
          description: l10n.multipleScanDescription,
          active: _multiple,
        );
    }
  }

  void _onScannerMenuActionSelected(_ScannerMenuAction action) {
    switch (action) {
      case _ScannerMenuAction.document:
        if (!_importing) unawaited(_pickDocument());
      case _ScannerMenuAction.continuous:
        unawaited(_toggleContinuousMode());
      case _ScannerMenuAction.multiple:
        unawaited(_toggleMultiple());
    }
  }

  void _handleControllerCreated(
    camera.CameraController? controller,
    Exception? error,
  ) {
    if (!mounted) return;
    if (error != null) {
      setState(() {
        _cameraController = null;
        _cameraSwitching = false;
        _cameraError = error;
      });
      return;
    }
    setState(() {
      _cameraController = controller;
      _cameraSwitching = false;
      _flashBusy = false;
      _cameraError = null;
    });
    if (controller != null) unawaited(_loadZoomBounds(controller));
  }

  Future<void> _loadZoomBounds(camera.CameraController controller) async {
    try {
      final minZoom = await controller.getMinZoomLevel();
      final maxZoom = await controller.getMaxZoomLevel();
      if (!mounted || !identical(_cameraController, controller)) return;
      setState(() {
        _minZoom = minZoom;
        _maxZoom = maxZoom;
        _zoom = minZoom;
      });
    } on Object catch (error) {
      debugPrint('Could not read camera zoom range: $error');
    }
  }

  void _setZoom(double value) {
    final controller = _cameraController;
    if (controller == null || _maxZoom <= _minZoom) return;
    setState(() => _zoom = value);
    unawaited(_applyZoom(controller, value));
  }

  Future<void> _applyZoom(
    camera.CameraController controller,
    double value,
  ) async {
    try {
      await controller.setZoomLevel(value);
    } on Object catch (error) {
      debugPrint('Could not set camera zoom: $error');
    }
  }

  Future<void> _toggleFlash() async {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized || _flashBusy) {
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    setState(() => _flashBusy = true);
    final enabled = controller.value.flashMode == camera.FlashMode.torch;
    try {
      await controller.setFlashMode(
        enabled ? camera.FlashMode.off : camera.FlashMode.torch,
      );
    } on Object {
      if (mounted) _showImportMessage(l10n.flashUnavailable, error: true);
    } finally {
      if (mounted) setState(() => _flashBusy = false);
    }
  }

  void _switchCamera() {
    if (_cameraController == null || _cameraSwitching) return;
    setState(() {
      _cameraSwitching = true;
      _cameraController = null;
      _lensDirection = _lensDirection == camera.CameraLensDirection.back
          ? camera.CameraLensDirection.front
          : camera.CameraLensDirection.back;
    });
  }

  Future<void> _toggleContinuousMode() async {
    final settings = ref.read(appSettingsProvider);
    final enabled = !settings.continuousMode;
    await settings.setContinuousMode(enabled);
    if (!enabled) {
      _recentContinuous.clear();
      _lastContinuousAt = null;
      await _finishContinuousSession();
      return;
    }
    if (mounted) await _showScannerModeHelp(_ScannerMode.continuous);
  }

  Future<void> _toggleMultiple() async {
    final enabled = !_multiple;
    if (mounted) setState(() => _multiple = enabled);
    if (enabled && mounted) {
      await _showScannerModeHelp(_ScannerMode.multiple);
    }
  }

  Future<void> _showScannerModeHelp(_ScannerMode mode) async {
    final settings = ref.read(appSettingsProvider);
    final alreadyDismissed = mode == _ScannerMode.continuous
        ? settings.continuousModeHelpDismissed
        : settings.multipleScanHelpDismissed;
    if (alreadyDismissed || !mounted) return;

    final l10n = AppLocalizations.of(context)!;
    var doNotShowAgain = false;
    final dismissed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          icon: Icon(
            mode == _ScannerMode.continuous
                ? Icons.playlist_add_check
                : Icons.select_all,
          ),
          title: Text(
            mode == _ScannerMode.continuous
                ? l10n.continuousModeTitle
                : l10n.multipleModeTitle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                mode == _ScannerMode.continuous
                    ? l10n.continuousModeExplanation
                    : l10n.multipleModeExplanation,
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: doNotShowAgain,
                onChanged: (value) =>
                    setDialogState(() => doNotShowAgain = value ?? false),
                title: Text(l10n.doNotShowAgain),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(doNotShowAgain),
              child: Text(l10n.close),
            ),
          ],
        ),
      ),
    );
    if (dismissed != true || !mounted) return;
    if (mode == _ScannerMode.continuous) {
      await settings.setContinuousModeHelpDismissed(true);
    } else {
      await settings.setMultipleScanHelpDismissed(true);
    }
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

enum _ScannerMode { continuous, multiple }

enum _ScannerMenuAction { document, continuous, multiple }

class _ScannerMenuItemData {
  const _ScannerMenuItemData({
    required this.icon,
    required this.title,
    required this.description,
    this.active = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool active;
}

class _ScannerBottomControls extends StatelessWidget {
  const _ScannerBottomControls({
    required this.scanAreaPercent,
    required this.zoom,
    required this.minZoom,
    required this.maxZoom,
    required this.multiple,
    required this.onScanAreaChanged,
    required this.onZoomChanged,
  });

  final double scanAreaPercent;
  final double zoom;
  final double minZoom;
  final double maxZoom;
  final bool multiple;
  final ValueChanged<double> onScanAreaChanged;
  final ValueChanged<double> onZoomChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final zoomAvailable = maxZoom > minZoom;
    final safeZoom = zoom.clamp(minZoom, maxZoom).toDouble();
    final areaValue = scanAreaPercent.clamp(0.3, 0.9).toDouble();
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      top: false,
      child: Material(
        color: Colors.black.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.crop_free, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      multiple
                          ? l10n.fullCameraFrame
                          : l10n.scanAreaValue((areaValue * 100).round()),
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Slider(
                value: areaValue,
                min: 0.3,
                max: 0.9,
                divisions: 12,
                label: l10n.scanAreaValue((areaValue * 100).round()),
                onChanged: multiple ? null : onScanAreaChanged,
              ),
              Row(
                children: [
                  const Icon(Icons.zoom_in, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.zoomValue(safeZoom.toStringAsFixed(1)),
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Slider(
                value: zoomAvailable ? safeZoom : 0,
                min: zoomAvailable ? minZoom : 0,
                max: zoomAvailable ? maxZoom : 1,
                label: zoomAvailable
                    ? l10n.zoomValue(safeZoom.toStringAsFixed(1))
                    : l10n.zoom,
                onChanged: zoomAvailable ? onZoomChanged : null,
              ),
            ],
          ),
        ),
      ),
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
