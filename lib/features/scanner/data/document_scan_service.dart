import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:file_selector/file_selector.dart';

import '../../../core/models/scan_models.dart';
import '../../../core/platform/document_render_service.dart';
import 'zxing_scanner_adapter.dart';

class DocumentScanException implements Exception {
  const DocumentScanException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

/// Reads local images and document containers without uploading their content.
///
/// PDFs are rasterized page by page by Android's PdfRenderer. Modern Office
/// files are ZIP containers, so their embedded media can be decoded directly.
/// This intentionally does not claim to render legacy binary Office files or
/// QR codes drawn as vector/text shapes inside Office documents.
class DocumentScanService {
  const DocumentScanService({
    this.decoder = const ZxingScannerAdapter(),
    this.renderer = const DocumentRenderService(),
  });

  static const int maxInputBytes = 50 * 1024 * 1024;
  static const int maxOfficeImages = 120;
  static const int maxOfficeImageBytes = 15 * 1024 * 1024;
  static const int maxOfficeImageTotalBytes = 120 * 1024 * 1024;

  static const List<String> imageExtensions = <String>[
    'jpg',
    'jpeg',
    'png',
    'webp',
    'bmp',
    'gif',
  ];

  static const List<String> pdfExtensions = <String>['pdf'];

  static const List<String> officeExtensions = <String>[
    'docx',
    'docm',
    'xlsx',
    'xlsm',
    'pptx',
    'pptm',
    'doc',
    'xls',
    'ppt',
  ];

  final ZxingScannerAdapter decoder;
  final DocumentRenderService renderer;

  static List<XTypeGroup> acceptedTypeGroups({
    required String imageLabel,
    required String pdfLabel,
    required String officeLabel,
  }) {
    return <XTypeGroup>[
      XTypeGroup(label: imageLabel, extensions: imageExtensions),
      XTypeGroup(label: pdfLabel, extensions: pdfExtensions),
      XTypeGroup(label: officeLabel, extensions: officeExtensions),
    ];
  }

  Future<List<BarcodeScanResult>> scan(
    XFile file, {
    required bool multiple,
  }) async {
    final name = file.name.isNotEmpty ? file.name : file.path;
    final extension = _extension(name);
    final bytes = await _readBytes(file);

    if (bytes.length > maxInputBytes) {
      throw const DocumentScanException(
        'file_too_large',
        'The selected file is too large to scan locally.',
      );
    }

    if (imageExtensions.contains(extension)) {
      return _markImported(
        await decoder.scanImageBytes(
          bytes,
          multiple: multiple,
          extension: '.$extension',
        ),
      );
    }

    if (pdfExtensions.contains(extension)) {
      return _scanPdf(bytes, multiple: multiple);
    }

    if (officeExtensions.contains(extension)) {
      return _scanOffice(bytes, extension: extension, multiple: multiple);
    }

    throw const DocumentScanException(
      'unsupported_extension',
      'This file type is not supported for QR scanning.',
    );
  }

  Future<Uint8List> _readBytes(XFile file) async {
    try {
      return await file.readAsBytes();
    } on Object catch (error) {
      throw DocumentScanException(
        'read_failed',
        'The selected file could not be read: $error',
      );
    }
  }

  Future<List<BarcodeScanResult>> _scanPdf(
    Uint8List bytes, {
    required bool multiple,
  }) async {
    final renderedPaths = await renderer.renderPdf(bytes);
    if (renderedPaths.isEmpty) return const <BarcodeScanResult>[];

    try {
      final results = <BarcodeScanResult>[];
      final seen = <String>{};
      for (final path in renderedPaths) {
        final pageResults = await decoder.scanImagePath(
          path,
          multiple: multiple,
          // flutter_zxing defaults file decoding to 768 px. That is too small
          // for small codes on a full-page tax/payment form.
          maxSize: 3000,
        );
        for (final result in pageResults) {
          final key = '${result.formatKey}|${result.rawValue}';
          final imported = _asImported(result);
          if (seen.add(key)) results.add(imported);
          if (!multiple) return <BarcodeScanResult>[imported];
        }
      }
      return results;
    } finally {
      await renderer.deleteRenderedFiles(renderedPaths);
      await _deleteTemporaryFiles(renderedPaths);
    }
  }

  Future<List<BarcodeScanResult>> _scanOffice(
    Uint8List bytes, {
    required String extension,
    required bool multiple,
  }) async {
    if (!_looksLikeZip(bytes)) {
      throw DocumentScanException(
        'legacy_office',
        'Legacy .$extension files are not supported. Choose a modern Office file such as .${extension}x.',
      );
    }

    final images = _extractOfficeImages(bytes);
    final results = <BarcodeScanResult>[];
    final seen = <String>{};
    for (final image in images) {
      final imageResults = await decoder.scanImageBytes(
        image.bytes,
        multiple: multiple,
        extension: image.extension,
      );
      for (final result in imageResults) {
        final key = '${result.formatKey}|${result.rawValue}';
        final imported = _asImported(result);
        if (seen.add(key)) results.add(imported);
        if (!multiple) return <BarcodeScanResult>[imported];
      }
    }
    return results;
  }

  List<BarcodeScanResult> _markImported(List<BarcodeScanResult> results) {
    return results.map(_asImported).toList(growable: false);
  }

  BarcodeScanResult _asImported(BarcodeScanResult result) {
    return BarcodeScanResult(
      rawValue: result.rawValue,
      format: result.format,
      source: ScanSource.imported,
      capturedAt: result.capturedAt,
      position: result.position,
    );
  }

  List<_EmbeddedImage> _extractOfficeImages(Uint8List bytes) {
    final Archive archive;
    try {
      archive = ZipDecoder().decodeBytes(bytes, verify: false);
    } on Object catch (error) {
      throw DocumentScanException(
        'invalid_office',
        'The Office file could not be opened: $error',
      );
    }

    final images = <_EmbeddedImage>[];
    var totalBytes = 0;
    for (final entry in archive) {
      final normalizedName = entry.name.replaceAll('\\', '/').toLowerCase();
      if (!entry.isFile || !_isOfficeMediaPath(normalizedName)) continue;
      final extension = _extension(normalizedName);
      if (!imageExtensions.contains(extension)) continue;
      if (images.length >= maxOfficeImages ||
          entry.size > maxOfficeImageBytes ||
          totalBytes + entry.size > maxOfficeImageTotalBytes) {
        throw const DocumentScanException(
          'office_too_large',
          'This Office file contains too many or too-large images to scan.',
        );
      }
      final content = entry.readBytes();
      if (content == null || content.isEmpty) continue;
      totalBytes += content.length;
      images.add(_EmbeddedImage(content, '.$extension'));
    }
    return images;
  }

  bool _isOfficeMediaPath(String path) {
    return path.startsWith('word/media/') ||
        path.startsWith('xl/media/') ||
        path.startsWith('ppt/media/') ||
        path.contains('/pictures/');
  }

  bool _looksLikeZip(Uint8List bytes) {
    return bytes.length >= 4 &&
        bytes[0] == 0x50 &&
        bytes[1] == 0x4b &&
        (bytes[2] == 0x03 || bytes[2] == 0x05 || bytes[2] == 0x07) &&
        (bytes[3] == 0x04 || bytes[3] == 0x06 || bytes[3] == 0x08);
  }

  String _extension(String name) {
    final normalized = name.replaceAll('\\', '/');
    final dot = normalized.lastIndexOf('.');
    if (dot < 0 || dot == normalized.length - 1) return '';
    return normalized.substring(dot + 1).toLowerCase();
  }

  Future<void> _deleteTemporaryFiles(List<String> paths) async {
    for (final path in paths) {
      try {
        await File(path).delete();
      } on Object {
        // Cache cleanup is best effort.
      }
    }
  }
}

class _EmbeddedImage {
  const _EmbeddedImage(this.bytes, this.extension);

  final Uint8List bytes;
  final String extension;
}
