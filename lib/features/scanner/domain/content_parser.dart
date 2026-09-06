import '../../../core/models/scan_models.dart';

class ContentParser {
  const ContentParser();

  static const int maxValueLength = 16 * 1024;
  static const int parserVersion = 1;

  ParsedContent parse(String rawValue) {
    final original = rawValue;
    if (rawValue.length > maxValueLength) {
      return ParsedContent(
        type: ContentType.text,
        original: original,
        warnings: const ['value_too_long'],
      );
    }

    final value = rawValue.replaceAll('\r\n', '\n').trim();
    if (value.isEmpty) {
      return const ParsedContent(type: ContentType.unknown, original: '');
    }

    final wifi = _parseWifi(value);
    if (wifi != null) return wifi;

    final contact = _parseContact(value);
    if (contact != null) return contact;

    final event = _parseEvent(value);
    if (event != null) return event;

    final geo = _parseGeo(value);
    if (geo != null) return geo;

    final sms = _parseSms(value);
    if (sms != null) return sms;

    final email = _parseEmail(value);
    if (email != null) return email;

    if (_looksLikeProduct(value)) {
      return ParsedContent(
        type: ContentType.product,
        original: original,
        fields: <String, String>{'code': value},
      );
    }

    final phone = _parsePhone(value);
    if (phone != null) return phone;

    final uri = Uri.tryParse(value);
    if (uri != null && _isSafeWebUri(uri)) {
      return ParsedContent(
        type: ContentType.url,
        original: original,
        fields: <String, String>{'url': uri.toString(), 'host': uri.host},
        actions: <ExternalAction>[
          ExternalAction(
            type: ExternalActionType.openUrl,
            labelKey: 'actionOpen',
            payload: <String, String>{'uri': uri.toString()},
          ),
        ],
      );
    }

    return ParsedContent(type: ContentType.text, original: original);
  }

  ParsedContent? _parseWifi(String value) {
    if (!value.toUpperCase().startsWith('WIFI:')) return null;
    final fields = <String, String>{};
    for (final part in value.substring(5).split(';')) {
      final separator = part.indexOf(':');
      if (separator <= 0) continue;
      final key = part.substring(0, separator).toUpperCase();
      fields[key] = _unescape(part.substring(separator + 1));
    }
    final ssid = fields['S'];
    if (ssid == null || ssid.isEmpty) {
      return ParsedContent(
        type: ContentType.wifi,
        original: value,
        fields: fields,
        warnings: const ['wifi_missing_ssid'],
      );
    }
    return ParsedContent(
      type: ContentType.wifi,
      original: value,
      fields: fields,
      actions: <ExternalAction>[
        const ExternalAction(
          type: ExternalActionType.openWifiSettings,
          labelKey: 'actionWifiSettings',
          payload: <String, String>{},
        ),
      ],
    );
  }

  ParsedContent? _parseContact(String value) {
    final upper = value.toUpperCase();
    if (upper.startsWith('BEGIN:VCARD')) {
      final fields = _lineFields(value);
      final name = fields['FN'] ?? fields['N'] ?? '';
      final phone = fields['TEL'] ?? '';
      return ParsedContent(
        type: ContentType.contact,
        original: value,
        fields: <String, String>{'name': name, 'phone': phone},
        warnings: name.isEmpty && phone.isEmpty
            ? const ['contact_missing_fields']
            : const <String>[],
        actions: <ExternalAction>[
          ExternalAction(
            type: ExternalActionType.insertContact,
            labelKey: 'actionSaveContact',
            payload: <String, String>{'name': name, 'phone': phone},
          ),
        ],
      );
    }
    if (!upper.startsWith('MECARD:')) return null;
    final fields = <String, String>{};
    for (final part in value.substring(7).split(';')) {
      final separator = part.indexOf(':');
      if (separator <= 0) continue;
      fields[part.substring(0, separator).toUpperCase()] = _unescape(
        part.substring(separator + 1),
      );
    }
    final name = fields['N'] ?? '';
    final phone = fields['TEL'] ?? '';
    return ParsedContent(
      type: ContentType.contact,
      original: value,
      fields: <String, String>{'name': name, 'phone': phone},
      actions: <ExternalAction>[
        ExternalAction(
          type: ExternalActionType.insertContact,
          labelKey: 'actionSaveContact',
          payload: <String, String>{'name': name, 'phone': phone},
        ),
      ],
    );
  }

  ParsedContent? _parseEvent(String value) {
    if (!value.toUpperCase().contains('BEGIN:VEVENT')) return null;
    final fields = _lineFields(value);
    final summary = fields['SUMMARY'] ?? '';
    return ParsedContent(
      type: ContentType.event,
      original: value,
      fields: <String, String>{
        'summary': summary,
        'start': fields['DTSTART'] ?? '',
      },
      actions: <ExternalAction>[
        ExternalAction(
          type: ExternalActionType.insertEvent,
          labelKey: 'actionSaveEvent',
          payload: <String, String>{
            'title': summary,
            'start': fields['DTSTART'] ?? '',
            'end': fields['DTEND'] ?? '',
          },
        ),
      ],
    );
  }

  ParsedContent? _parseGeo(String value) {
    final match = RegExp(
      r'^geo:([-+]?\d+(?:\.\d+)?),([-+]?\d+(?:\.\d+)?)(?:\?q=(.*))?$',
      caseSensitive: false,
    ).firstMatch(value);
    if (match == null) return null;
    final latitude = double.tryParse(match.group(1)!);
    final longitude = double.tryParse(match.group(2)!);
    if (latitude == null ||
        longitude == null ||
        latitude.abs() > 90 ||
        longitude.abs() > 180) {
      return ParsedContent(
        type: ContentType.geo,
        original: value,
        warnings: const ['geo_invalid'],
      );
    }
    return ParsedContent(
      type: ContentType.geo,
      original: value,
      fields: <String, String>{
        'latitude': '$latitude',
        'longitude': '$longitude',
        if (match.group(3) != null) 'label': _decodeComponent(match.group(3)!),
      },
      actions: <ExternalAction>[
        ExternalAction(
          type: ExternalActionType.openGeo,
          labelKey: 'actionOpenMap',
          payload: <String, String>{'uri': value},
        ),
      ],
    );
  }

  ParsedContent? _parseSms(String value) {
    final match = RegExp(
      r'^sms:([^?]+)(?:\?body=(.*))?$',
      caseSensitive: false,
    ).firstMatch(value);
    if (match == null) return null;
    final phone = match.group(1)!;
    final body = match.group(2) == null
        ? ''
        : _decodeComponent(match.group(2)!);
    return ParsedContent(
      type: ContentType.sms,
      original: value,
      fields: <String, String>{'phone': phone, 'body': body},
      actions: <ExternalAction>[
        ExternalAction(
          type: ExternalActionType.composeSms,
          labelKey: 'actionSendSms',
          payload: <String, String>{'phone': phone, 'body': body},
        ),
      ],
    );
  }

  ParsedContent? _parseEmail(String value) {
    Uri? uri;
    if (value.toLowerCase().startsWith('mailto:')) {
      uri = Uri.tryParse(value);
    } else if (RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      uri = Uri(scheme: 'mailto', path: value);
    }
    if (uri == null || uri.path.isEmpty) return null;
    return ParsedContent(
      type: ContentType.email,
      original: value,
      fields: <String, String>{'address': uri.path, ...uri.queryParameters},
      actions: <ExternalAction>[
        ExternalAction(
          type: ExternalActionType.composeEmail,
          labelKey: 'actionSendEmail',
          payload: <String, String>{'uri': uri.toString()},
        ),
      ],
    );
  }

  ParsedContent? _parsePhone(String value) {
    if (!RegExp(r'^\+?[0-9 ()-]{7,20}$').hasMatch(value)) return null;
    final phone = value.replaceAll(RegExp(r'[ ()-]'), '');
    return ParsedContent(
      type: ContentType.phone,
      original: value,
      fields: <String, String>{'phone': phone},
      actions: <ExternalAction>[
        ExternalAction(
          type: ExternalActionType.dial,
          labelKey: 'actionCall',
          payload: <String, String>{'phone': phone},
        ),
      ],
    );
  }

  Map<String, String> _lineFields(String value) {
    final result = <String, String>{};
    for (final line in value.split('\n')) {
      final separator = line.indexOf(':');
      if (separator <= 0) continue;
      final key = line.substring(0, separator).split(';').first.toUpperCase();
      result[key] = line.substring(separator + 1).trim();
    }
    return result;
  }

  bool _isSafeWebUri(Uri uri) =>
      (uri.scheme.toLowerCase() == 'http' ||
          uri.scheme.toLowerCase() == 'https') &&
      uri.host.isNotEmpty;

  bool _looksLikeProduct(String value) =>
      RegExp(r'^\d{8}$|^\d{12,14}$').hasMatch(value);

  String _unescape(String value) => value
      .replaceAll(r'\;', ';')
      .replaceAll(r'\:', ':')
      .replaceAll(r'\,', ',')
      .replaceAll(r'\\', r'\');

  String _decodeComponent(String value) {
    try {
      return Uri.decodeComponent(value);
    } on FormatException {
      return value;
    }
  }
}
