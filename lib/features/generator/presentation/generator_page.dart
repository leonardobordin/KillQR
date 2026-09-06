import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zxing/flutter_zxing.dart' as zxing;
import 'package:share_plus/share_plus.dart';

import '../../../core/platform/gallery_save_service.dart';
import '../../../l10n/app_localizations.dart';
import '../data/zxing_generator_adapter.dart';

class GeneratorPage extends ConsumerStatefulWidget {
  const GeneratorPage({super.key});

  @override
  ConsumerState<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends ConsumerState<GeneratorPage> {
  static const _adapter = ZxingGeneratorAdapter();
  final _contentController = TextEditingController(text: 'KillQR');
  late int _format;
  String _template = 'text';
  String _suggestedContent = 'KillQR';
  GeneratedBarcode? _generated;
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _format = _adapter.writableFormats.first;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final templatesEnabled = _adapter.supportsContentTemplates(_format);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.generateTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _contentController,
            minLines: 3,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              labelText: l10n.content,
              prefixIcon: const Icon(Icons.edit_outlined),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _template,
            decoration: InputDecoration(labelText: l10n.template),
            items: [
              DropdownMenuItem(value: 'text', child: Text(l10n.templateText)),
              DropdownMenuItem(value: 'url', child: Text(l10n.templateUrl)),
              DropdownMenuItem(value: 'wifi', child: Text(l10n.templateWifi)),
              DropdownMenuItem(value: 'email', child: Text(l10n.templateEmail)),
              DropdownMenuItem(value: 'sms', child: Text(l10n.templateSms)),
              DropdownMenuItem(
                value: 'contact',
                child: Text(l10n.templateContact),
              ),
            ],
            onChanged: !templatesEnabled
                ? null
                : (value) {
                    if (value == null) return;
                    setState(() {
                      _template = value;
                      _setSuggestedContent(_templateContent(value));
                    });
                  },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<int>(
            initialValue: _format,
            decoration: InputDecoration(labelText: l10n.barcodeFormat),
            items: _adapter.writableFormats
                .map(
                  (format) => DropdownMenuItem<int>(
                    value: format,
                    child: Text(format.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              final currentContent = _contentController.text;
              final canReplaceContent =
                  currentContent.trim().isEmpty ||
                  currentContent == _suggestedContent ||
                  currentContent == _templateContent(_template);
              setState(() {
                _format = value;
                if (canReplaceContent) {
                  _setSuggestedContent(_adapter.suggestedContentFor(value));
                }
              });
            },
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _generate,
            icon: const Icon(Icons.auto_awesome),
            label: Text(l10n.generate),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: ListTile(
                leading: const Icon(Icons.error_outline),
                title: Text(_error!),
              ),
            ),
          ],
          if (_generated != null) ...[
            const SizedBox(height: 20),
            Text(
              l10n.generatedPreview,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Image.memory(
                  _generated!.png,
                  height: 280,
                  width: 280,
                  fit: BoxFit.contain,
                  semanticLabel: l10n.generatedPreview,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _copy,
                    icon: const Icon(Icons.copy_outlined),
                    label: Text(l10n.copy),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _share,
                    icon: const Icon(Icons.share_outlined),
                    label: Text(l10n.share),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_alt_outlined),
              label: Text(l10n.savePng),
            ),
          ],
        ],
      ),
    );
  }

  String _templateContent(String template) {
    switch (template) {
      case 'url':
        return 'https://example.com';
      case 'wifi':
        return 'WIFI:T:WPA;S:Network;P:Password;;';
      case 'email':
        return 'mailto:person@example.com';
      case 'sms':
        return 'SMSTO:+5511999999999:Mensagem';
      case 'contact':
        return 'BEGIN:VCARD\nVERSION:3.0\nFN:Name\nTEL:+5511999999999\nEND:VCARD';
      case 'text':
        return 'KillQR';
    }
    return 'KillQR';
  }

  void _setSuggestedContent(String content) {
    _suggestedContent = content;
    _contentController.value = TextEditingValue(
      text: content,
      selection: TextSelection.collapsed(offset: content.length),
    );
  }

  void _generate() {
    try {
      final generated = _adapter.generate(
        text: _contentController.text,
        format: _format,
      );
      setState(() {
        _generated = generated;
        _error = null;
      });
    } on FormatException catch (error) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _generated = null;
        _error = switch (error.message) {
          'empty_content' => l10n.invalidContent,
          'unsupported_format' => l10n.unsupportedFormat,
          'invalid_barcode_content' => l10n.invalidBarcodeContent,
          _ => l10n.generationFailed,
        };
      });
    }
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: _contentController.text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.copied)),
    );
  }

  Future<void> _share() async {
    final generated = _generated;
    if (generated == null) return;
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            generated.png,
            mimeType: 'image/png',
            name: 'killqr.png',
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final generated = _generated;
    if (generated == null || _saving) return;
    setState(() => _saving = true);
    final l10n = AppLocalizations.of(context)!;
    try {
      await const GallerySaveService().savePng(generated.png);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.savedToGallery)));
    } on GallerySaveException catch (error) {
      if (!mounted) return;
      final message = error.code == 'permission_denied'
          ? l10n.galleryPermissionDenied
          : l10n.gallerySaveFailed;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
