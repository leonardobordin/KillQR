import 'package:flutter_zxing/flutter_zxing.dart' as zxing;

enum ScanSource { camera, continuous, image, imported, generated }

enum ContentType {
  text,
  url,
  phone,
  sms,
  email,
  wifi,
  contact,
  geo,
  event,
  product,
  unknown,
}

enum ExternalActionType {
  openUrl,
  dial,
  composeSms,
  composeEmail,
  openGeo,
  insertContact,
  insertEvent,
  openWifiSettings,
  productSearch,
}

class BarcodeScanResult {
  const BarcodeScanResult({
    required this.rawValue,
    required this.format,
    required this.source,
    this.capturedAt,
    this.position,
  });

  final String rawValue;
  final int format;
  final ScanSource source;
  final DateTime? capturedAt;
  final zxing.Position? position;

  String get formatKey => formatKeyFor(format);
  String get formatLabel => format.name;
}

String formatKeyFor(int format) {
  switch (format) {
    case zxing.Format.aztec:
      return 'aztec';
    case zxing.Format.codabar:
      return 'codabar';
    case zxing.Format.code39:
      return 'code39';
    case zxing.Format.code93:
      return 'code93';
    case zxing.Format.code128:
      return 'code128';
    case zxing.Format.dataMatrix:
      return 'data_matrix';
    case zxing.Format.ean8:
      return 'ean8';
    case zxing.Format.ean13:
      return 'ean13';
    case zxing.Format.itf:
      return 'itf';
    case zxing.Format.maxiCode:
      return 'maxicode';
    case zxing.Format.pdf417:
      return 'pdf417';
    case zxing.Format.qrCode:
      return 'qr_code';
    case zxing.Format.upca:
      return 'upca';
    case zxing.Format.upce:
      return 'upce';
    case zxing.Format.microQRCode:
      return 'micro_qr';
    case zxing.Format.rmqrCode:
      return 'rmqr';
    case zxing.Format.dataBar:
      return 'databar';
    case zxing.Format.dataBarExpanded:
      return 'databar_expanded';
    case zxing.Format.dataBarLimited:
      return 'databar_limited';
    case zxing.Format.dxFilmEdge:
      return 'dx_film_edge';
    case zxing.Format.telepen:
      return 'telepen';
    case zxing.Format.microPdf417:
      return 'micro_pdf417';
    default:
      return 'unknown';
  }
}

int formatFromKey(String key) {
  switch (key) {
    case 'aztec':
      return zxing.Format.aztec;
    case 'codabar':
      return zxing.Format.codabar;
    case 'code39':
      return zxing.Format.code39;
    case 'code93':
      return zxing.Format.code93;
    case 'code128':
      return zxing.Format.code128;
    case 'data_matrix':
      return zxing.Format.dataMatrix;
    case 'ean8':
      return zxing.Format.ean8;
    case 'ean13':
      return zxing.Format.ean13;
    case 'itf':
      return zxing.Format.itf;
    case 'maxicode':
      return zxing.Format.maxiCode;
    case 'pdf417':
      return zxing.Format.pdf417;
    case 'qr_code':
      return zxing.Format.qrCode;
    case 'upca':
      return zxing.Format.upca;
    case 'upce':
      return zxing.Format.upce;
    case 'micro_qr':
      return zxing.Format.microQRCode;
    case 'rmqr':
      return zxing.Format.rmqrCode;
    case 'databar':
      return zxing.Format.dataBar;
    case 'databar_expanded':
      return zxing.Format.dataBarExpanded;
    case 'databar_limited':
      return zxing.Format.dataBarLimited;
    case 'dx_film_edge':
      return zxing.Format.dxFilmEdge;
    case 'telepen':
      return zxing.Format.telepen;
    case 'micro_pdf417':
      return zxing.Format.microPdf417;
    default:
      return zxing.Format.any;
  }
}

String scanSourceKey(ScanSource source) => source.name;

ScanSource scanSourceFromKey(String value) => ScanSource.values.firstWhere(
  (source) => source.name == value,
  orElse: () => ScanSource.imported,
);

ContentType contentTypeFromKey(String value) => ContentType.values.firstWhere(
  (type) => type.name == value,
  orElse: () => ContentType.unknown,
);

class ExternalAction {
  const ExternalAction({
    required this.type,
    required this.labelKey,
    required this.payload,
    this.requiresConfirmation = true,
  });

  final ExternalActionType type;
  final String labelKey;
  final Map<String, String> payload;
  final bool requiresConfirmation;
}

class ParsedContent {
  const ParsedContent({
    required this.type,
    required this.original,
    this.fields = const <String, String>{},
    this.warnings = const <String>[],
    this.actions = const <ExternalAction>[],
  });

  final ContentType type;
  final String original;
  final Map<String, String> fields;
  final List<String> warnings;
  final List<ExternalAction> actions;
}
