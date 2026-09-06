import 'package:flutter_test/flutter_test.dart';
import 'package:killqr/core/models/scan_models.dart';
import 'package:killqr/features/scanner/domain/content_parser.dart';

void main() {
  const parser = ContentParser();

  test('recognizes safe web URLs and exposes only an explicit action', () {
    final parsed = parser.parse('https://example.com/path?q=1');

    expect(parsed.type, ContentType.url);
    expect(parsed.actions, hasLength(1));
    expect(parsed.actions.single.type, ExternalActionType.openUrl);
    expect(parsed.actions.single.requiresConfirmation, isTrue);
  });

  test('keeps executable or unknown schemes as plain text', () {
    for (final value in <String>[
      'javascript:alert(1)',
      'intent://settings',
      'file:///etc/passwd',
      'custom:payload',
    ]) {
      final parsed = parser.parse(value);
      expect(parsed.type, ContentType.text, reason: value);
      expect(parsed.actions, isEmpty, reason: value);
    }
  });

  test('parses Wi-Fi, vCard, geo and phone payloads conservatively', () {
    expect(
      parser.parse(r'WIFI:T:WPA;S:Office\;Guest;P:secret;;').type,
      ContentType.wifi,
    );
    expect(
      parser.parse('BEGIN:VCARD\nFN:Ana\nTEL:+5511999999999\nEND:VCARD').type,
      ContentType.contact,
    );
    expect(parser.parse('geo:-23.55,-46.63').type, ContentType.geo);
    expect(parser.parse('+55 (11) 99999-9999').type, ContentType.phone);
    expect(parser.parse('geo:120,0').warnings, isNotEmpty);
  });

  test('detects email, event, product and malformed empty values', () {
    expect(parser.parse('person@example.com').type, ContentType.email);
    expect(
      parser
          .parse('BEGIN:VEVENT\nSUMMARY:Demo\nDTSTART:20260905\nEND:VEVENT')
          .type,
      ContentType.event,
    );
    expect(parser.parse('7891234567890').type, ContentType.product);
    expect(parser.parse('   ').type, ContentType.unknown);
  });
}
