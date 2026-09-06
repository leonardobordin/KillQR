import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:killqr/features/generator/data/zxing_generator_adapter.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

void main() {
  test('ZXing can encode and decode a QR payload', () async {
    const payload = 'KillQR bootstrap spike';
    final encoded = zx.encodeBarcode(
      contents: payload,
      params: EncodeParams(
        format: Format.qrCode,
        width: 256,
        height: 256,
        margin: 8,
      ),
    );

    expect(encoded.isValid, isTrue, reason: encoded.error);
    expect(encoded.data, isNotNull);
    expect(encoded.width, isPositive);
    expect(encoded.height, isPositive);

    final directory = await Directory.systemTemp.createTemp('killqr-zxing-');
    final image = File('${directory.path}${Platform.pathSeparator}probe.png');
    addTearDown(() => directory.delete(recursive: true));
    await image.writeAsBytes(
      pngFromBytes(encoded.data!, encoded.width!, encoded.height!),
    );

    final decoded = await zx.readBarcodeImagePathString(
      image.path,
      DecodeParams(),
    );

    expect(decoded.isValid, isTrue, reason: decoded.error);
    expect(decoded.text, payload);
  }, skip: !Platform.isAndroid);

  test('encoder capabilities come from flutter_zxing', () {
    expect(CodeFormat.supportedEncodeFormats, isNotEmpty);
    expect(CodeFormat.supportedEncodeFormats, contains(Format.qrCode));
    expect(CodeFormat.supportedEncodeFormats, isNot(contains(Format.telepen)));
  });

  test('generator supplies valid examples for linear formats', () {
    const adapter = ZxingGeneratorAdapter();

    expect(adapter.suggestedContentFor(Format.codabar), 'A123456789B');
    expect(adapter.suggestedContentFor(Format.ean8), '9031101');
    expect(adapter.suggestedContentFor(Format.ean13), '978020137962');
    expect(adapter.suggestedContentFor(Format.itf), '00012345600012');
    expect(adapter.suggestedContentFor(Format.upca), '72527273070');
    expect(adapter.suggestedContentFor(Format.upce), '0123456');
    expect(adapter.supportsContentTemplates(Format.qrCode), isTrue);
    expect(adapter.supportsContentTemplates(Format.ean13), isFalse);
  });
}
