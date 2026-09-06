import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zxing/flutter_zxing.dart' as zxing;
import 'package:killqr/core/models/scan_models.dart';
import 'package:killqr/features/scanner/data/document_scan_service.dart';
import 'package:killqr/features/scanner/data/zxing_scanner_adapter.dart';

void main() {
  test('accepts image, PDF and Office picker groups', () {
    final groups = DocumentScanService.acceptedTypeGroups(
      imageLabel: 'Images',
      pdfLabel: 'PDF',
      officeLabel: 'Office',
    );

    expect(groups, hasLength(3));
    expect(groups[0].extensions, contains('png'));
    expect(groups[1].extensions, contains('pdf'));
    expect(groups[2].extensions, contains('docx'));
  });

  test('scans image media embedded in a modern Office ZIP', () async {
    final archive = Archive()
      ..addFile(ArchiveFile.bytes('word/media/image1.png', <int>[1, 2, 3]));
    final officeBytes = ZipEncoder().encodeBytes(archive);
    final directory = await Directory.systemTemp.createTemp('killqr-office-');
    addTearDown(() => directory.delete(recursive: true));
    final officeFile = File('${directory.path}/with-code.docx');
    await officeFile.writeAsBytes(officeBytes);
    final file = XFile(officeFile.path);
    final service = DocumentScanService(decoder: const _FakeDecoder());

    final results = await service.scan(file, multiple: false);

    expect(results, hasLength(1));
    expect(results.single.rawValue, 'embedded-code');
    expect(results.single.source, ScanSource.imported);
  });

  test('reports legacy binary Office files clearly', () async {
    final directory = await Directory.systemTemp.createTemp('killqr-office-');
    addTearDown(() => directory.delete(recursive: true));
    final officeFile = File('${directory.path}/old.doc');
    await officeFile.writeAsBytes(
      Uint8List.fromList(<int>[0xd0, 0xcf, 0x11, 0xe0]),
    );
    final file = XFile(officeFile.path);
    final service = DocumentScanService(decoder: const _FakeDecoder());

    expect(
      () => service.scan(file, multiple: false),
      throwsA(
        isA<DocumentScanException>().having(
          (error) => error.code,
          'code',
          'legacy_office',
        ),
      ),
    );
  });
}

class _FakeDecoder extends ZxingScannerAdapter {
  const _FakeDecoder();

  @override
  Future<List<BarcodeScanResult>> scanImageBytes(
    Uint8List bytes, {
    required bool multiple,
    String extension = '.png',
    int maxSize = 2400,
  }) async {
    return <BarcodeScanResult>[
      BarcodeScanResult(
        rawValue: 'embedded-code',
        format: zxing.Format.qrCode,
        source: ScanSource.image,
        capturedAt: DateTime.utc(2026, 9, 5),
      ),
    ];
  }
}
