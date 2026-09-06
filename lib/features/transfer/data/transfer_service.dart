import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/database/app_database.dart';
import '../../../core/models/scan_models.dart';

enum DuplicatePolicy { skip, importAsNew, cancel }

class TransferRecord {
  const TransferRecord({
    required this.rawValue,
    required this.formatKey,
    required this.contentType,
    required this.source,
    required this.createdAtUtc,
    required this.isFavorite,
    required this.note,
    this.batchSessionId,
    this.tagNames = const <String>[],
  });

  final String rawValue;
  final String formatKey;
  final String contentType;
  final String source;
  final DateTime createdAtUtc;
  final bool isFavorite;
  final String? note;
  final int? batchSessionId;
  final List<String> tagNames;

  Map<String, Object?> toJson() => <String, Object?>{
    'rawValue': rawValue,
    'formatKey': formatKey,
    'contentType': contentType,
    'source': source,
    'createdAtUtc': createdAtUtc.toUtc().toIso8601String(),
    'isFavorite': isFavorite,
    if (note != null) 'note': note,
    if (batchSessionId != null) 'batchSessionId': batchSessionId,
    if (tagNames.isNotEmpty) 'tags': tagNames,
  };

  static TransferRecord? fromJson(Object? value) {
    if (value is! Map) return null;
    final raw = value['rawValue'];
    final format = value['formatKey'];
    final type = value['contentType'];
    final source = value['source'];
    final created = value['createdAtUtc'];
    if (raw is! String ||
        raw.isEmpty ||
        raw.length > 16 * 1024 ||
        format is! String ||
        type is! String ||
        source is! String ||
        created is! String) {
      return null;
    }
    final date = DateTime.tryParse(created);
    if (date == null) return null;
    final rawTags = value['tags'];
    final tagNames = rawTags is List
        ? rawTags
              .whereType<String>()
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty && tag.length <= 64)
              .take(50)
              .toList(growable: false)
        : const <String>[];
    final batchSessionId = value['batchSessionId'] is int
        ? value['batchSessionId'] as int
        : null;
    return TransferRecord(
      rawValue: raw,
      formatKey: format,
      contentType: type,
      source: source,
      createdAtUtc: date.toUtc(),
      isFavorite: value['isFavorite'] == true,
      note: value['note'] is String ? value['note'] as String : null,
      batchSessionId: batchSessionId,
      tagNames: tagNames,
    );
  }
}

class ImportPreview {
  const ImportPreview({required this.records, required this.errors});

  final List<TransferRecord> records;
  final List<String> errors;
}

class TransferService {
  const TransferService();

  static const int maxFileBytes = 10 * 1024 * 1024;
  static const int maxRecords = 10 * 10000;

  Future<List<TransferRecord>> recordsFromDatabase(
    AppDatabase database, {
    Iterable<int>? ids,
  }) async {
    final records = ids == null
        ? await database.queryScans(limit: maxRecords)
        : (await Future.wait(ids.take(maxRecords).map(database.getScan)))
              .whereType<ScanRecord>()
              .toList(growable: false);
    final tags = await database.getTagsForScans(
      records.map((record) => record.id),
    );
    return records
        .map(
          (record) => TransferRecord(
            rawValue: record.rawValue,
            formatKey: record.formatKey,
            contentType: record.contentType,
            source: record.source,
            createdAtUtc: DateTime.fromMillisecondsSinceEpoch(
              record.createdAtMs,
              isUtc: true,
            ),
            isFavorite: record.isFavorite,
            note: record.note,
            batchSessionId: record.batchSessionId,
            tagNames: tags[record.id] ?? const <String>[],
          ),
        )
        .toList(growable: false);
  }

  String encodeJson(List<TransferRecord> records) =>
      const JsonEncoder.withIndent('  ').convert(<String, Object?>{
        'format': 'killqr-export',
        'version': 1,
        'exportedAtUtc': DateTime.now().toUtc().toIso8601String(),
        'records': records.map((record) => record.toJson()).toList(),
      });

  String encodeCsv(List<TransferRecord> records) {
    final rows = <List<String>>[
      <String>[
        'format',
        'version',
        'rawValue',
        'formatKey',
        'contentType',
        'source',
        'createdAtUtc',
        'isFavorite',
        'note',
        'batchSessionId',
        'tags',
      ],
      ...records.map(
        (record) => <String>[
          'killqr-export',
          '1',
          record.rawValue,
          record.formatKey,
          record.contentType,
          record.source,
          record.createdAtUtc.toIso8601String(),
          record.isFavorite.toString(),
          record.note ?? '',
          record.batchSessionId?.toString() ?? '',
          jsonEncode(record.tagNames),
        ],
      ),
    ];
    return rows.map((row) => row.map(_csvCell).join(',')).join('\r\n');
  }

  ImportPreview parse(String content, {required String extension}) {
    if (content.length > maxFileBytes) {
      return const ImportPreview(records: [], errors: ['file_too_large']);
    }
    if (extension.toLowerCase() == 'csv') return _parseCsv(content);
    return _parseJson(content);
  }

  Future<TransferResult> exportToFile(
    AppDatabase database, {
    required bool csv,
    Iterable<int>? ids,
  }) async {
    final records = await recordsFromDatabase(database, ids: ids);
    final content = csv ? encodeCsv(records) : encodeJson(records);
    final extension = csv ? 'csv' : 'json';
    final location = await getSaveLocation(
      acceptedTypeGroups: [
        XTypeGroup(label: extension.toUpperCase(), extensions: [extension]),
      ],
      suggestedName: 'killqr-export.$extension',
    );
    if (location == null || location.path.isEmpty) {
      return const TransferResult.cancelled();
    }
    await File(location.path).writeAsString(content, flush: true);
    return TransferResult.saved(location.path);
  }

  Future<ImportPreview?> openImport() async {
    final file = await openFile(
      acceptedTypeGroups: const [
        XTypeGroup(label: 'KillQR export', extensions: ['json', 'csv']),
      ],
    );
    if (file == null) return null;
    final bytes = await file.length();
    if (bytes > maxFileBytes) {
      return const ImportPreview(records: [], errors: ['file_too_large']);
    }
    final extension = file.name.toLowerCase().endsWith('.csv') ? 'csv' : 'json';
    return parse(await file.readAsString(), extension: extension);
  }

  Future<int> importRecords(
    AppDatabase database,
    List<TransferRecord> records, {
    required DuplicatePolicy policy,
  }) async {
    final existing = (await database.queryScans(limit: maxRecords))
        .map((record) => '${record.formatKey}|${record.rawValue}')
        .toSet();
    if (policy == DuplicatePolicy.cancel &&
        records.any(
          (record) =>
              existing.contains('${record.formatKey}|${record.rawValue}'),
        )) {
      return 0;
    }
    var imported = 0;
    await database.transaction(() async {
      final sessionMap = <int, int>{};
      for (final record in records) {
        final key = '${record.formatKey}|${record.rawValue}';
        if (existing.contains(key)) {
          if (policy == DuplicatePolicy.skip) continue;
          if (policy == DuplicatePolicy.cancel) break;
        }
        int? sessionId;
        if (record.batchSessionId != null) {
          sessionId = sessionMap[record.batchSessionId!];
          sessionId ??= sessionMap[record.batchSessionId!] = await database
              .createContinuousSession();
        }
        final scanId = await database.insertScan(
          rawValue: record.rawValue,
          formatKey: record.formatKey,
          contentType: record.contentType,
          source: _safeSource(record.source),
          createdAt: record.createdAtUtc,
          isFavorite: record.isFavorite,
          note: record.note,
          batchSessionId: sessionId,
        );
        if (record.tagNames.isNotEmpty) {
          await database.setTagsForScan(scanId, record.tagNames);
        }
        existing.add(key);
        imported++;
      }
    });
    return imported;
  }

  Future<void> shareExport(
    AppDatabase database, {
    required bool csv,
    Iterable<int>? ids,
  }) async {
    final records = await recordsFromDatabase(database, ids: ids);
    final content = csv ? encodeCsv(records) : encodeJson(records);
    final extension = csv ? 'csv' : 'json';
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            utf8.encode(content),
            name: 'killqr-export.$extension',
            mimeType: csv ? 'text/csv' : 'application/json',
          ),
        ],
      ),
    );
  }

  ImportPreview _parseJson(String content) {
    try {
      final decoded = jsonDecode(content);
      if (decoded is! Map ||
          decoded['format'] != 'killqr-export' ||
          decoded['version'] != 1) {
        return const ImportPreview(records: [], errors: ['unknown_format']);
      }
      final values = decoded['records'];
      if (values is! List || values.length > maxRecords) {
        return const ImportPreview(records: [], errors: ['invalid_records']);
      }
      final records = <TransferRecord>[];
      final errors = <String>[];
      for (var index = 0; index < values.length; index++) {
        final record = TransferRecord.fromJson(values[index]);
        if (record == null) {
          errors.add('record_${index + 1}');
        } else {
          records.add(record);
        }
      }
      return ImportPreview(records: records, errors: errors);
    } on FormatException {
      return const ImportPreview(records: [], errors: ['invalid_json']);
    }
  }

  ImportPreview _parseCsv(String content) {
    final rows = _parseCsvRows(content);
    if (rows.isEmpty) {
      return const ImportPreview(records: [], errors: ['empty_csv']);
    }
    final header = rows.first;
    final expected = <String>[
      'format',
      'version',
      'rawValue',
      'formatKey',
      'contentType',
      'source',
      'createdAtUtc',
      'isFavorite',
      'note',
      'batchSessionId',
      'tags',
    ];
    final legacyExpected = expected.sublist(0, 9);
    final isLegacy = _listEquals(header, legacyExpected);
    if ((!isLegacy && header.length != expected.length) ||
        (!isLegacy && !_listEquals(header, expected))) {
      return const ImportPreview(records: [], errors: ['invalid_csv_header']);
    }
    final records = <TransferRecord>[];
    final errors = <String>[];
    for (var index = 1; index < rows.length; index++) {
      final row = rows[index];
      if (row.length != (isLegacy ? legacyExpected.length : expected.length) ||
          row[0] != 'killqr-export' ||
          row[1] != '1') {
        errors.add('row_${index + 1}');
        continue;
      }
      final record = TransferRecord.fromJson(<String, Object?>{
        'rawValue': row[2],
        'formatKey': row[3],
        'contentType': row[4],
        'source': row[5],
        'createdAtUtc': row[6],
        'isFavorite': row[7].toLowerCase() == 'true',
        'note': row[8],
        if (!isLegacy) 'batchSessionId': int.tryParse(row[9]),
        if (!isLegacy && row.length > 10) 'tags': _decodeTagsCell(row[10]),
      });
      if (record == null) {
        errors.add('row_${index + 1}');
      } else {
        records.add(record);
      }
    }
    return ImportPreview(records: records, errors: errors);
  }

  List<List<String>> _parseCsvRows(String content) {
    final rows = <List<String>>[];
    var row = <String>[];
    var field = StringBuffer();
    var quoted = false;
    for (var i = 0; i < content.length; i++) {
      final char = content[i];
      if (quoted) {
        if (char == '"') {
          if (i + 1 < content.length && content[i + 1] == '"') {
            field.write('"');
            i++;
          } else {
            quoted = false;
          }
        } else {
          field.write(char);
        }
      } else if (char == '"' && field.isEmpty) {
        quoted = true;
      } else if (char == ',') {
        row.add(field.toString());
        field = StringBuffer();
      } else if (char == '\n') {
        row.add(field.toString().replaceAll('\r', ''));
        rows.add(row);
        row = <String>[];
        field = StringBuffer();
      } else {
        field.write(char);
      }
    }
    if (field.isNotEmpty || row.isNotEmpty) {
      row.add(field.toString());
      rows.add(row);
    }
    return rows;
  }

  String _csvCell(String value) {
    if (!value.contains(RegExp(r'[",\r\n]'))) return value;
    return '"${value.replaceAll('"', '""')}"';
  }

  List<String> _decodeTagsCell(String value) {
    try {
      final decoded = jsonDecode(value);
      return decoded is List ? decoded.whereType<String>().toList() : const [];
    } on FormatException {
      return const [];
    }
  }

  String _safeSource(String value) =>
      ScanSource.values.any((source) => source.name == value)
      ? value
      : ScanSource.imported.name;

  bool _listEquals(List<String> first, List<String> second) {
    if (first.length != second.length) return false;
    for (var i = 0; i < first.length; i++) {
      if (first[i] != second[i]) return false;
    }
    return true;
  }
}

class TransferResult {
  const TransferResult._({this.path, this.wasCancelled = false});

  const TransferResult.saved(String path) : this._(path: path);

  const TransferResult.cancelled() : this._(wasCancelled: true);

  final String? path;
  final bool wasCancelled;
}
