import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:killqr/core/database/app_database.dart';

void main() {
  test('opens Drift on a background isolate and creates its schema', () async {
    final directory = await Directory.systemTemp.createTemp('killqr-db-');
    final database = await AppDatabase.openAt(directory);

    addTearDown(() async {
      await database.close();
      await directory.delete(recursive: true);
    });

    expect(await database.verifyBootstrapSchema(), isTrue);
  });
}
