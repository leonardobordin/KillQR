import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';

import '../core/database/app_database.dart';
import '../features/generator/data/zxing_generator_adapter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NativeSmokeApp());
}

class NativeSmokeApp extends StatelessWidget {
  const NativeSmokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<NativeSmokeResult>(
        future: runNativeSmoke(),
        builder: (context, snapshot) {
          final result = snapshot.data;
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  snapshot.connectionState != ConnectionState.done
                      ? 'RUNNING NATIVE SMOKE'
                      : result == null
                      ? 'NATIVE SMOKE FAILED: ${snapshot.error}'
                      : 'DRIFT: ${result.driftReady ? 'PASS' : 'FAIL'}\n'
                            'ZXING ENCODE/DECODE: '
                            '${result.zxingReady ? 'PASS' : 'FAIL'}\n'
                            'PAYLOAD: ${result.payload}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NativeSmokeResult {
  const NativeSmokeResult({
    required this.driftReady,
    required this.zxingReady,
    required this.payload,
  });

  final bool driftReady;
  final bool zxingReady;
  final String payload;
}

Future<NativeSmokeResult> runNativeSmoke() async {
  const payload = 'KillQR Android native smoke';
  const formatProbes = <({int format, String contents})>[
    (format: Format.codabar, contents: 'A123456789B'),
    (format: Format.ean8, contents: '9031101'),
    (format: Format.ean13, contents: '978020137962'),
    (format: Format.itf, contents: '00012345600012'),
    (format: Format.upca, contents: '72527273070'),
    (format: Format.upce, contents: '0123456'),
  ];
  final directory = await Directory.systemTemp.createTemp('killqr-smoke-');
  AppDatabase? database;
  File? image;

  try {
    database = await AppDatabase.openAt(directory);
    final driftReady = await database.verifyBootstrapSchema();

    final encoded = zx.encodeBarcode(
      contents: payload,
      params: EncodeParams(
        format: Format.qrCode,
        width: 256,
        height: 256,
        margin: 8,
      ),
    );
    if (!encoded.isValid || encoded.data == null) {
      throw StateError('ZXing encode failed: ${encoded.error}');
    }

    image = File('${directory.path}${Platform.pathSeparator}probe.png');
    await image.writeAsBytes(
      pngFromBytes(encoded.data!, encoded.width!, encoded.height!),
    );
    final decoded = await zx.readBarcodeImagePathString(
      image.path,
      DecodeParams(),
    );
    if (!decoded.isValid || decoded.text != payload) {
      throw StateError('ZXing decode failed: ${decoded.error}');
    }

    const generator = ZxingGeneratorAdapter();
    final formatFailures = <String>[];
    for (final probe in formatProbes) {
      final generated = generator.generate(
        text: probe.contents,
        format: probe.format,
      );
      await image.writeAsBytes(generated.png, flush: true);
      final decodedFormat = await zx.readBarcodeImagePathString(
        image.path,
        DecodeParams(
          format: Format.any,
          tryHarder: true,
          tryRotate: true,
          tryDownscale: true,
          maxSize: 3000,
        ),
      );
      if (!decodedFormat.isValid ||
          !_matchesGeneratedText(
            probe.format,
            generated.text,
            decodedFormat.text,
          )) {
        formatFailures.add(
          '${probe.format.name}: ${decodedFormat.text ?? decodedFormat.error ?? 'decode failed'}',
        );
      }
    }
    if (formatFailures.isNotEmpty) {
      throw StateError(
        'ZXing format matrix failed: ${formatFailures.join('; ')}',
      );
    }

    return NativeSmokeResult(
      driftReady: driftReady,
      zxingReady: true,
      payload: decoded.text!,
    );
  } finally {
    await database?.close();
    await directory.delete(recursive: true);
  }
}

bool _matchesGeneratedText(int format, String expected, String? actual) {
  if (actual == expected) return true;
  switch (format) {
    case Format.ean8:
    case Format.ean13:
      return actual?.startsWith(expected) ?? false;
    case Format.upca:
    case Format.upce:
      return actual != null && RegExp(r'^\d+$').hasMatch(actual);
    default:
      return false;
  }
}
