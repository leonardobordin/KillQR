import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart' as zxing;
import 'package:path_provider/path_provider.dart';

import '../../../core/models/scan_models.dart';
import 'rectangular_reader.dart';

class ScannerCapabilities {
  const ScannerCapabilities({
    required this.readFormats,
    required this.writeFormats,
    this.camera = true,
    this.image = true,
    this.multiple = true,
    this.points = true,
    this.torch = true,
    this.zoom = true,
  });

  final List<int> readFormats;
  final List<int> writeFormats;
  final bool camera;
  final bool image;
  final bool multiple;
  final bool points;
  final bool torch;
  final bool zoom;
}

class ZxingScannerAdapter {
  const ZxingScannerAdapter();

  ScannerCapabilities get capabilities => ScannerCapabilities(
    readFormats: const [zxing.Format.any],
    writeFormats: List<int>.unmodifiable(
      zxing.CodeFormat.supportedEncodeFormats,
    ),
  );

  Widget reader({
    required ValueChanged<BarcodeScanResult> onResult,
    ValueChanged<List<BarcodeScanResult>>? onMultipleResults,
    ValueChanged<Object>? onError,
    required bool multiple,
    required zxing.CameraLensDirection lensDirection,
    required void Function(zxing.CameraController?, Exception?)
    onControllerCreated,
    double scanAreaWidth = 0.62,
    double scanAreaHeight = 0.52,
  }) {
    return RectangularReaderWidget(
      key: const ValueKey('killqr-reader'),
      lensDirection: lensDirection,
      multiple: multiple,
      scanAreaWidth: scanAreaWidth,
      scanAreaHeight: scanAreaHeight,
      onScan: (code) {
        final result = _toResult(code);
        if (result != null) onResult(result);
      },
      onMultiScan: (codes) {
        final results = codes.codes
            .map(_toResult)
            .whereType<BarcodeScanResult>()
            .toList(growable: false);
        if (results.isNotEmpty) onMultipleResults?.call(results);
      },
      onControllerCreated: onControllerCreated,
      onError: onError,
    );
  }

  Future<List<BarcodeScanResult>> scanImagePath(
    String path, {
    required bool multiple,
    int maxSize = 3000,
  }) async {
    final params = _imageParams(multiple: multiple, maxSize: maxSize);
    if (multiple) {
      final codes = await zxing.zx.readBarcodesImagePathString(path, params);
      return codes.codes
          .map((code) => _toResult(code, source: ScanSource.image))
          .whereType<BarcodeScanResult>()
          .toList(growable: false);
    }

    final code = await zxing.zx.readBarcodeImagePathString(path, params);
    final result = _toResult(code, source: ScanSource.image);
    return result == null
        ? const <BarcodeScanResult>[]
        : <BarcodeScanResult>[result];
  }

  Future<List<BarcodeScanResult>> scanImageBytes(
    Uint8List bytes, {
    required bool multiple,
    String extension = '.png',
    int maxSize = 2400,
  }) async {
    final temporaryDirectory = await getTemporaryDirectory();
    final safeExtension = _safeExtension(extension);
    final file = File(
      '${temporaryDirectory.path}/killqr_scan_${DateTime.now().microsecondsSinceEpoch}$safeExtension',
    );
    await file.writeAsBytes(bytes, flush: true);
    try {
      return await scanImagePath(
        file.path,
        multiple: multiple,
        maxSize: maxSize,
      );
    } finally {
      try {
        await file.delete();
      } on Object {
        // A cache file is best-effort cleanup and must not hide scan results.
      }
    }
  }

  zxing.DecodeParams _imageParams({
    required bool multiple,
    required int maxSize,
  }) {
    return zxing.DecodeParams(
      imageFormat: zxing.ImageFormat.rgb,
      format: zxing.Format.any,
      tryHarder: true,
      tryRotate: true,
      tryInverted: true,
      tryDownscale: true,
      maxNumberOfSymbols: 20,
      maxSize: maxSize,
      isMultiScan: multiple,
    );
  }

  String _safeExtension(String extension) {
    final value = extension.startsWith('.') ? extension : '.$extension';
    return RegExp(r'^\.[a-zA-Z0-9]{1,8}$').hasMatch(value) ? value : '.bin';
  }

  BarcodeScanResult? _toResult(zxing.Code code, {ScanSource? source}) {
    final text = code.text?.trim();
    final format = code.format;
    if (!code.isValid || text == null || text.isEmpty || format == null) {
      return null;
    }
    return BarcodeScanResult(
      rawValue: text,
      format: format,
      source:
          source ??
          (code.source == zxing.CodeSource.localImageFile
              ? ScanSource.image
              : ScanSource.camera),
      capturedAt: DateTime.now().toUtc(),
      position: code.position,
    );
  }
}
