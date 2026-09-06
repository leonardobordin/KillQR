import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:killqr/core/database/app_database.dart';

void main() {
  test('persists notes, favorites, tags and searchable filters', () async {
    final directory = await Directory.systemTemp.createTemp('killqr-features-');
    final database = await AppDatabase.openAt(directory);
    addTearDown(() async {
      await database.close();
      await directory.delete(recursive: true);
    });

    final session = await database.createContinuousSession();
    final scanId = await database.insertScan(
      rawValue: 'https://example.com',
      formatKey: 'qr_code',
      contentType: 'url',
      source: 'continuous',
      createdAt: DateTime.utc(2026, 9, 5),
      isFavorite: true,
      note: 'work link',
      batchSessionId: session,
    );
    await database.setTagsForScan(scanId, const ['work', 'links']);

    final byTag = await database.queryScans(tagName: 'work');
    expect(byTag.map((row) => row.id), contains(scanId));
    expect((await database.queryScans(search: 'work')).single.id, scanId);
    expect((await database.queryScans(favoriteOnly: true)).single.id, scanId);
    expect((await database.getTagsForScan(scanId)).map((tag) => tag.name), [
      'links',
      'work',
    ]);

    await database.updateScan(id: scanId, isFavorite: false, note: null);
    expect((await database.queryScans(favoriteOnly: true)), isEmpty);
    await database.deleteScan(scanId);
    expect(await database.getAllTags(), isEmpty);
  });

  test('history watcher emits newly inserted scans', () async {
    final directory = await Directory.systemTemp.createTemp('killqr-watch-');
    final database = await AppDatabase.openAt(directory);
    addTearDown(() async {
      await database.close();
      await directory.delete(recursive: true);
    });

    final nextScan = database
        .watchScans()
        .firstWhere((rows) => rows.isNotEmpty)
        .timeout(const Duration(seconds: 2));
    await database.insertScan(
      rawValue: 'history-watcher',
      formatKey: 'qr_code',
      contentType: 'text',
      source: 'camera',
      createdAt: DateTime.utc(2026, 9, 5),
    );

    final rows = await nextScan;
    expect(rows.single.rawValue, 'history-watcher');
  });

  test('validates configurable search engines', () async {
    final directory = await Directory.systemTemp.createTemp('killqr-engines-');
    final database = await AppDatabase.openAt(directory);
    addTearDown(() async {
      await database.close();
      await directory.delete(recursive: true);
    });

    final before = await database.getSearchEngines();
    expect(before, isNotEmpty);
    await expectLater(
      database.insertSearchEngine(
        name: 'Invalid',
        template: 'javascript:alert(1)',
      ),
      throwsArgumentError,
    );
    final id = await database.insertSearchEngine(
      name: 'Local',
      template: 'https://search.example/?q={CODE}',
    );
    expect(
      (await database.getSearchEngines()).any((engine) => engine.id == id),
      isTrue,
    );
  });
}
