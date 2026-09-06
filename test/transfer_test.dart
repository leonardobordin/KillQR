import 'package:flutter_test/flutter_test.dart';
import 'package:killqr/features/transfer/data/transfer_service.dart';

void main() {
  const service = TransferService();
  final created = DateTime.utc(2026, 9, 5, 15, 0, 0);
  final source = TransferRecord(
    rawValue: 'line 1, "quoted"\nline 2',
    formatKey: 'qr_code',
    contentType: 'text',
    source: 'camera',
    createdAtUtc: created,
    isFavorite: true,
    note: 'note, with a comma',
    batchSessionId: 7,
    tagNames: const ['work', 'quoted,tag'],
  );

  test('JSON round-trip preserves relevant fields', () {
    final encoded = service.encodeJson([source]);
    final preview = service.parse(encoded, extension: 'json');

    expect(preview.errors, isEmpty);
    expect(preview.records, hasLength(1));
    expect(preview.records.single.rawValue, source.rawValue);
    expect(preview.records.single.note, source.note);
    expect(preview.records.single.isFavorite, isTrue);
    expect(preview.records.single.batchSessionId, 7);
    expect(preview.records.single.tagNames, source.tagNames);
  });

  test('CSV round-trip handles commas, quotes and newlines', () {
    final encoded = service.encodeCsv([source]);
    final preview = service.parse(encoded, extension: 'csv');

    expect(preview.errors, isEmpty);
    expect(preview.records.single.rawValue, source.rawValue);
    expect(preview.records.single.note, source.note);
    expect(preview.records.single.tagNames, source.tagNames);
  });

  test('rejects malformed and unknown envelopes without throwing', () {
    expect(
      service.parse('{"format":"other","version":1}', extension: 'json').errors,
      contains('unknown_format'),
    );
    expect(
      service.parse('{not-json', extension: 'json').errors,
      contains('invalid_json'),
    );
    expect(
      service.parse('format,version\nwrong,1', extension: 'csv').errors,
      contains('invalid_csv_header'),
    );
  });
}
