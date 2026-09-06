import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class BootstrapProbes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get marker => text()();
}

class ContinuousSessions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get startedAtMs => integer().named('started_at_ms')();

  IntColumn get finishedAtMs => integer().named('finished_at_ms').nullable()();
}

class ScanRecords extends Table {
  @override
  String get tableName => 'scans';

  IntColumn get id => integer().autoIncrement()();

  TextColumn get rawValue => text().named('raw_value')();

  TextColumn get formatKey => text().named('format_key')();

  TextColumn get contentType => text().named('content_type')();

  TextColumn get source => text()();

  IntColumn get createdAtMs => integer().named('created_at_ms')();

  BoolColumn get isFavorite =>
      boolean().named('is_favorite').withDefault(const Constant(false))();

  TextColumn get note => text().nullable()();

  IntColumn get parserVersion =>
      integer().named('parser_version').withDefault(const Constant(1))();

  IntColumn get batchSessionId => integer()
      .named('batch_session_id')
      .nullable()
      .references(ContinuousSessions, #id, onDelete: KeyAction.setNull)();
}

class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();
}

class ScanTags extends Table {
  IntColumn get scanId => integer()
      .named('scan_id')
      .references(ScanRecords, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId => integer()
      .named('tag_id')
      .references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column<Object>> get primaryKey => {scanId, tagId};
}

class SearchEngines extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get template => text()();

  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  IntColumn get sortOrder => integer().named('sort_order')();
}

@DriftDatabase(
  tables: [
    BootstrapProbes,
    ContinuousSessions,
    ScanRecords,
    Tags,
    ScanTags,
    SearchEngines,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  static Future<AppDatabase> openForApplication() async {
    final directory = await getApplicationSupportDirectory();
    final database = await openAt(directory);
    if (!await database.verifySchema()) {
      await database.close();
      throw StateError('KillQR database schema was not created correctly.');
    }
    return database;
  }

  static Future<AppDatabase> openAt(Directory directory) async {
    await directory.create(recursive: true);
    final file = File(
      '${directory.path}${Platform.pathSeparator}killqr.sqlite3',
    );
    final database = AppDatabase(NativeDatabase.createInBackground(file));
    await database.customSelect('SELECT 1').get();
    return database;
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _createIndexes();
      await _seedSearchEngines();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(continuousSessions);
        await migrator.createTable(scanRecords);
        await migrator.createTable(tags);
        await migrator.createTable(scanTags);
        await migrator.createTable(searchEngines);
        await _createIndexes();
        await _seedSearchEngines();
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> _createIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS scans_created_at_idx '
      'ON scans (created_at_ms DESC, id DESC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS scans_content_type_idx '
      'ON scans (content_type)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS scans_format_key_idx '
      'ON scans (format_key)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS scans_favorite_idx '
      'ON scans (is_favorite)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS scans_batch_session_idx '
      'ON scans (batch_session_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS scan_tags_tag_idx '
      'ON scan_tags (tag_id)',
    );
  }

  Future<void> _seedSearchEngines() async {
    final existing = await select(searchEngines).get();
    if (existing.isNotEmpty) return;
    await batch((batch) {
      batch.insertAll(searchEngines, <SearchEnginesCompanion>[
        SearchEnginesCompanion.insert(
          name: 'DuckDuckGo',
          template: 'https://duckduckgo.com/?q={CODE}',
          sortOrder: 0,
        ),
        SearchEnginesCompanion.insert(
          name: 'Google',
          template: 'https://www.google.com/search?q={CODE}',
          sortOrder: 1,
        ),
      ]);
    });
  }

  Future<bool> verifySchema() async {
    final rows = await customSelect(
      "SELECT name FROM sqlite_master WHERE type = 'table' AND name IN "
      "('bootstrap_probes', 'scans', 'tags', 'scan_tags', "
      "'continuous_sessions', 'search_engines')",
    ).get();
    return rows.length == 6;
  }

  Future<bool> verifyBootstrapSchema() => verifySchema();

  Future<int> insertScan({
    required String rawValue,
    required String formatKey,
    required String contentType,
    required String source,
    required DateTime createdAt,
    bool isFavorite = false,
    String? note,
    int parserVersion = 1,
    int? batchSessionId,
  }) {
    return into(scanRecords).insert(
      ScanRecordsCompanion.insert(
        rawValue: rawValue,
        formatKey: formatKey,
        contentType: contentType,
        source: source,
        createdAtMs: createdAt.toUtc().millisecondsSinceEpoch,
        isFavorite: Value(isFavorite),
        note: Value(note),
        parserVersion: Value(parserVersion),
        batchSessionId: Value(batchSessionId),
      ),
    );
  }

  Future<List<ScanRecord>> queryScans({
    String search = '',
    String? contentType,
    String? formatKey,
    String? source,
    String? tagName,
    bool? favoriteOnly,
    int? batchSessionId,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int limit = 50,
    int offset = 0,
  }) => _scanQuery(
    search: search,
    contentType: contentType,
    formatKey: formatKey,
    source: source,
    tagName: tagName,
    favoriteOnly: favoriteOnly,
    batchSessionId: batchSessionId,
    createdAfter: createdAfter,
    createdBefore: createdBefore,
    limit: limit,
    offset: offset,
  ).get();

  Stream<List<ScanRecord>> watchScans({
    String search = '',
    String? contentType,
    String? formatKey,
    String? source,
    String? tagName,
    bool? favoriteOnly,
    int? batchSessionId,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int limit = 50,
    int offset = 0,
  }) => _scanQuery(
    search: search,
    contentType: contentType,
    formatKey: formatKey,
    source: source,
    tagName: tagName,
    favoriteOnly: favoriteOnly,
    batchSessionId: batchSessionId,
    createdAfter: createdAfter,
    createdBefore: createdBefore,
    limit: limit,
    offset: offset,
  ).watch();

  Selectable<ScanRecord> _scanQuery({
    String search = '',
    String? contentType,
    String? formatKey,
    String? source,
    String? tagName,
    bool? favoriteOnly,
    int? batchSessionId,
    DateTime? createdAfter,
    DateTime? createdBefore,
    int limit = 50,
    int offset = 0,
  }) {
    final query = select(scanRecords);
    if (search.trim().isNotEmpty) {
      final term = search.trim();
      query.where(
        (row) => row.rawValue.contains(term) | row.note.contains(term),
      );
    }
    if (contentType != null) {
      query.where((row) => row.contentType.equals(contentType));
    }
    if (formatKey != null) {
      query.where((row) => row.formatKey.equals(formatKey));
    }
    if (source != null) {
      query.where((row) => row.source.equals(source));
    }
    if (favoriteOnly == true) {
      query.where((row) => row.isFavorite.equals(true));
    }
    if (batchSessionId != null) {
      query.where((row) => row.batchSessionId.equals(batchSessionId));
    }
    if (createdAfter != null) {
      query.where(
        (row) => row.createdAtMs.isBiggerOrEqualValue(
          createdAfter.toUtc().millisecondsSinceEpoch,
        ),
      );
    }
    if (createdBefore != null) {
      query.where(
        (row) => row.createdAtMs.isSmallerOrEqualValue(
          createdBefore.toUtc().millisecondsSinceEpoch,
        ),
      );
    }
    if (tagName != null && tagName.trim().isNotEmpty) {
      query.where(
        (row) => row.id.isInQuery(
          selectOnly(scanTags)
            ..addColumns([scanTags.scanId])
            ..join([innerJoin(tags, tags.id.equalsExp(scanTags.tagId))])
            ..where(tags.name.equals(tagName.trim())),
        ),
      );
    }
    query.orderBy(<OrderingTerm Function(ScanRecords)>[
      (row) => OrderingTerm.desc(row.createdAtMs),
      (row) => OrderingTerm.desc(row.id),
    ]);
    query.limit(limit, offset: offset);
    return query;
  }

  Stream<List<ScanRecord>> watchRecentScans({int limit = 100}) =>
      watchScans(limit: limit);

  Future<ScanRecord?> getScan(int id) => (select(
    scanRecords,
  )..where((row) => row.id.equals(id))).getSingleOrNull();

  Future<bool> updateScan({
    required int id,
    String? note,
    bool? isFavorite,
  }) async {
    final changed =
        await (update(scanRecords)..where((row) => row.id.equals(id))).write(
          ScanRecordsCompanion(
            note: note == null ? const Value.absent() : Value(note),
            isFavorite: isFavorite == null
                ? const Value.absent()
                : Value(isFavorite),
          ),
        );
    return changed > 0;
  }

  Future<int> deleteScan(int id) async {
    final deleted = await (delete(
      scanRecords,
    )..where((row) => row.id.equals(id))).go();
    if (deleted > 0) await deleteOrphanTags();
    return deleted;
  }

  Future<int> deleteAllScans() async {
    final deleted = await delete(scanRecords).go();
    await deleteOrphanTags();
    return deleted;
  }

  Future<List<Tag>> getTagsForScan(int scanId) {
    final query =
        select(tags)
            .join([innerJoin(scanTags, scanTags.tagId.equalsExp(tags.id))])
          ..where(scanTags.scanId.equals(scanId))
          ..orderBy([OrderingTerm.asc(tags.name)]);
    return query.map((row) => row.readTable(tags)).get();
  }

  Future<Map<int, List<String>>> getTagsForScans(Iterable<int> scanIds) async {
    final ids = scanIds.toSet().toList(growable: false);
    if (ids.isEmpty) return <int, List<String>>{};
    final query =
        select(scanTags)
            .join([innerJoin(tags, tags.id.equalsExp(scanTags.tagId))])
          ..where(scanTags.scanId.isIn(ids))
          ..orderBy([OrderingTerm.asc(tags.name)]);
    final result = <int, List<String>>{};
    for (final row in await query.get()) {
      result
          .putIfAbsent(row.read(scanTags.scanId)!, () => <String>[])
          .add(row.readTable(tags).name);
    }
    return result;
  }

  Future<List<Tag>> getAllTags() =>
      (select(tags)..orderBy([(row) => OrderingTerm.asc(row.name)])).get();

  Future<int> getOrCreateTag(String rawName) async {
    final name = rawName.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (name.isEmpty || name.length > 64) {
      throw ArgumentError.value(
        rawName,
        'rawName',
        'Tag must have 1–64 characters.',
      );
    }
    final existing = await (select(
      tags,
    )..where((row) => row.name.equals(name))).getSingleOrNull();
    return existing?.id ?? into(tags).insert(TagsCompanion.insert(name: name));
  }

  Future<void> setTagsForScan(int scanId, Iterable<String> names) async {
    final normalized = names
        .map((name) => name.trim().replaceAll(RegExp(r'\s+'), ' '))
        .where((name) => name.isNotEmpty)
        .toSet();
    await transaction(() async {
      await (delete(scanTags)..where((row) => row.scanId.equals(scanId))).go();
      for (final name in normalized) {
        final tagId = await getOrCreateTag(name);
        await into(scanTags).insert(
          ScanTagsCompanion.insert(scanId: scanId, tagId: tagId),
          mode: InsertMode.insertOrIgnore,
        );
      }
      await deleteOrphanTags();
    });
  }

  Future<void> deleteOrphanTags() async {
    await customStatement(
      'DELETE FROM tags WHERE id NOT IN (SELECT DISTINCT tag_id FROM scan_tags)',
    );
  }

  Future<int> createContinuousSession() => into(continuousSessions).insert(
    ContinuousSessionsCompanion.insert(
      startedAtMs: DateTime.now().toUtc().millisecondsSinceEpoch,
    ),
  );

  Future<void> finishContinuousSession(int id) async {
    await (update(continuousSessions)..where((row) => row.id.equals(id))).write(
      ContinuousSessionsCompanion(
        finishedAtMs: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
      ),
    );
  }

  Future<List<SearchEngine>> getSearchEngines() => (select(
    searchEngines,
  )..orderBy([(row) => OrderingTerm.asc(row.sortOrder)])).get();

  Future<int> insertSearchEngine({
    required String name,
    required String template,
    bool isActive = true,
  }) async {
    _validateSearchTemplate(template);
    return into(searchEngines).insert(
      SearchEnginesCompanion.insert(
        name: name.trim().isEmpty ? 'Search' : name.trim(),
        template: template.trim(),
        isActive: Value(isActive),
        sortOrder: await _nextSearchOrder(),
      ),
    );
  }

  Future<bool> updateSearchEngine({
    required int id,
    required String name,
    required String template,
    required bool isActive,
  }) async {
    _validateSearchTemplate(template);
    final changed =
        await (update(searchEngines)..where((row) => row.id.equals(id))).write(
          SearchEnginesCompanion(
            name: Value(name.trim().isEmpty ? 'Search' : name.trim()),
            template: Value(template.trim()),
            isActive: Value(isActive),
          ),
        );
    return changed > 0;
  }

  Future<int> deleteSearchEngine(int id) =>
      (delete(searchEngines)..where((row) => row.id.equals(id))).go();

  Future<int> _nextSearchOrder() async {
    final row = await customSelect(
      'SELECT COALESCE(MAX(sort_order), -1) + 1 AS next_order FROM search_engines',
    ).getSingle();
    return row.read<int>('next_order');
  }

  void _validateSearchTemplate(String rawTemplate) {
    final template = rawTemplate.trim();
    final uri = Uri.tryParse(template.replaceAll('{CODE}', 'probe'));
    if (uri == null ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty ||
        !template.contains('{CODE}')) {
      throw ArgumentError.value(
        rawTemplate,
        'template',
        'Search template must be an http(s) URL containing {CODE}.',
      );
    }
  }
}
