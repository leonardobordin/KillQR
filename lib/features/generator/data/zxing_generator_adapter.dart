import 'dart:typed_data';

import 'package:flutter_zxing/flutter_zxing.dart' as zxing;

class GeneratedBarcode {
  const GeneratedBarcode({
    required this.format,
    required this.text,
    required this.png,
    required this.width,
    required this.height,
  });

  final int format;
  final String text;
  final Uint8List png;
  final int width;
  final int height;
}

class ZxingGeneratorAdapter {
  const ZxingGeneratorAdapter();

  List<int> get writableFormats =>
      List<int>.unmodifiable(zxing.CodeFormat.supportedEncodeFormats);

  String suggestedContentFor(int format) {
    final demoText = format.demoText;
    return demoText.isEmpty ? 'KillQR' : demoText;
  }

  bool supportsContentTemplates(int format) {
    return format & zxing.Format.linearCodes == 0;
  }

  GeneratedBarcode generate({
    required String text,
    required int format,
    int size = 640,
  }) {
    final normalizedText = text.trim();
    if (normalizedText.isEmpty) {
      throw const FormatException('empty_content');
    }
    if (!writableFormats.contains(format)) {
      throw const FormatException('unsupported_format');
    }
    _validateContent(normalizedText, format);
    final isLinear = format & zxing.Format.linearCodes != 0;
    final height = isLinear
        ? (size / format.ratio).round().clamp(160, size).toInt()
        : size;
    final encoded = zxing.zx.encodeBarcode(
      contents: normalizedText,
      params: zxing.EncodeParams(
        format: format,
        width: size,
        height: height,
        margin: isLinear ? 16 : 12,
        eccLevel: zxing.EccLevel.low,
      ),
    );
    if (!encoded.isValid ||
        encoded.data == null ||
        encoded.width == null ||
        encoded.height == null) {
      throw FormatException(encoded.error ?? 'encode_failed');
    }
    return GeneratedBarcode(
      format: format,
      text: normalizedText,
      png: zxing.pngFromBytes(encoded.data!, encoded.width!, encoded.height!),
      width: encoded.width!,
      height: encoded.height!,
    );
  }

  void _validateContent(String text, int format) {
    final numeric = RegExp(r'^\d+$');
    switch (format) {
      case zxing.Format.codabar:
        if (!RegExp(r'^[0-9\-$:/.+ABCD]+$').hasMatch(text)) {
          throw const FormatException('invalid_barcode_content');
        }
      case zxing.Format.ean8:
        if (!RegExp(r'^\d{7}$').hasMatch(text)) {
          throw const FormatException('invalid_barcode_content');
        }
      case zxing.Format.ean13:
        if (!RegExp(r'^\d{12}$').hasMatch(text)) {
          throw const FormatException('invalid_barcode_content');
        }
      case zxing.Format.itf:
        if (!numeric.hasMatch(text) || text.length.isOdd) {
          throw const FormatException('invalid_barcode_content');
        }
      case zxing.Format.upca:
        if (!RegExp(r'^\d{11}$').hasMatch(text)) {
          throw const FormatException('invalid_barcode_content');
        }
      case zxing.Format.upce:
        if (!RegExp(r'^\d{7}$').hasMatch(text)) {
          throw const FormatException('invalid_barcode_content');
        }
    }
  }
}
