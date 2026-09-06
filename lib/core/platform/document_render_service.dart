import 'package:flutter/services.dart';

class DocumentRenderException implements Exception {
  const DocumentRenderException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

/// Renders document pages using Android's local PdfRenderer API.
///
/// The returned paths point to PNG files in the app's cache directory. They
/// are intentionally kept private to the app and are deleted by the caller
/// after decoding.
class DocumentRenderService {
  const DocumentRenderService();

  static const _channel = MethodChannel('com.killstreak.killqr/documents');

  Future<List<String>> renderPdf(Uint8List bytes) async {
    try {
      final rendered = await _channel.invokeMethod<List<Object?>>(
        'renderPdf',
        <String, Object>{'bytes': bytes, 'maxPages': 50, 'maxDimension': 3000},
      );
      return rendered?.whereType<String>().toList(growable: false) ??
          const <String>[];
    } on PlatformException catch (error) {
      throw DocumentRenderException(
        error.code,
        error.message ?? 'The PDF could not be rendered.',
      );
    }
  }

  Future<void> deleteRenderedFiles(List<String> paths) async {
    if (paths.isEmpty) return;
    try {
      await _channel.invokeMethod<void>('deleteRenderedFiles', <String, Object>{
        'paths': paths,
      });
    } on PlatformException {
      // The Dart caller also removes individual files as a fallback.
    }
  }
}
