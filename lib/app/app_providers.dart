import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/app_database.dart';

final databaseProvider = FutureProvider<AppDatabase>((ref) async {
  final database = await AppDatabase.openForApplication();
  ref.onDispose(() {
    unawaited(database.close());
  });
  return database;
});
