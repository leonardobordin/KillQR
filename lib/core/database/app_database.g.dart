// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BootstrapProbesTable extends BootstrapProbes
    with TableInfo<$BootstrapProbesTable, BootstrapProbe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BootstrapProbesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _markerMeta = const VerificationMeta('marker');
  @override
  late final GeneratedColumn<String> marker = GeneratedColumn<String>(
    'marker',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, marker];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bootstrap_probes';
  @override
  VerificationContext validateIntegrity(
    Insertable<BootstrapProbe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('marker')) {
      context.handle(
        _markerMeta,
        marker.isAcceptableOrUnknown(data['marker']!, _markerMeta),
      );
    } else if (isInserting) {
      context.missing(_markerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BootstrapProbe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BootstrapProbe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      marker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marker'],
      )!,
    );
  }

  @override
  $BootstrapProbesTable createAlias(String alias) {
    return $BootstrapProbesTable(attachedDatabase, alias);
  }
}

class BootstrapProbe extends DataClass implements Insertable<BootstrapProbe> {
  final int id;
  final String marker;
  const BootstrapProbe({required this.id, required this.marker});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['marker'] = Variable<String>(marker);
    return map;
  }

  BootstrapProbesCompanion toCompanion(bool nullToAbsent) {
    return BootstrapProbesCompanion(id: Value(id), marker: Value(marker));
  }

  factory BootstrapProbe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BootstrapProbe(
      id: serializer.fromJson<int>(json['id']),
      marker: serializer.fromJson<String>(json['marker']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'marker': serializer.toJson<String>(marker),
    };
  }

  BootstrapProbe copyWith({int? id, String? marker}) =>
      BootstrapProbe(id: id ?? this.id, marker: marker ?? this.marker);
  BootstrapProbe copyWithCompanion(BootstrapProbesCompanion data) {
    return BootstrapProbe(
      id: data.id.present ? data.id.value : this.id,
      marker: data.marker.present ? data.marker.value : this.marker,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BootstrapProbe(')
          ..write('id: $id, ')
          ..write('marker: $marker')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, marker);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BootstrapProbe &&
          other.id == this.id &&
          other.marker == this.marker);
}

class BootstrapProbesCompanion extends UpdateCompanion<BootstrapProbe> {
  final Value<int> id;
  final Value<String> marker;
  const BootstrapProbesCompanion({
    this.id = const Value.absent(),
    this.marker = const Value.absent(),
  });
  BootstrapProbesCompanion.insert({
    this.id = const Value.absent(),
    required String marker,
  }) : marker = Value(marker);
  static Insertable<BootstrapProbe> custom({
    Expression<int>? id,
    Expression<String>? marker,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (marker != null) 'marker': marker,
    });
  }

  BootstrapProbesCompanion copyWith({Value<int>? id, Value<String>? marker}) {
    return BootstrapProbesCompanion(
      id: id ?? this.id,
      marker: marker ?? this.marker,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (marker.present) {
      map['marker'] = Variable<String>(marker.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BootstrapProbesCompanion(')
          ..write('id: $id, ')
          ..write('marker: $marker')
          ..write(')'))
        .toString();
  }
}

class $ContinuousSessionsTable extends ContinuousSessions
    with TableInfo<$ContinuousSessionsTable, ContinuousSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContinuousSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startedAtMsMeta = const VerificationMeta(
    'startedAtMs',
  );
  @override
  late final GeneratedColumn<int> startedAtMs = GeneratedColumn<int>(
    'started_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMsMeta = const VerificationMeta(
    'finishedAtMs',
  );
  @override
  late final GeneratedColumn<int> finishedAtMs = GeneratedColumn<int>(
    'finished_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, startedAtMs, finishedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'continuous_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContinuousSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at_ms')) {
      context.handle(
        _startedAtMsMeta,
        startedAtMs.isAcceptableOrUnknown(
          data['started_at_ms']!,
          _startedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startedAtMsMeta);
    }
    if (data.containsKey('finished_at_ms')) {
      context.handle(
        _finishedAtMsMeta,
        finishedAtMs.isAcceptableOrUnknown(
          data['finished_at_ms']!,
          _finishedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContinuousSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContinuousSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at_ms'],
      )!,
      finishedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}finished_at_ms'],
      ),
    );
  }

  @override
  $ContinuousSessionsTable createAlias(String alias) {
    return $ContinuousSessionsTable(attachedDatabase, alias);
  }
}

class ContinuousSession extends DataClass
    implements Insertable<ContinuousSession> {
  final int id;
  final int startedAtMs;
  final int? finishedAtMs;
  const ContinuousSession({
    required this.id,
    required this.startedAtMs,
    this.finishedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at_ms'] = Variable<int>(startedAtMs);
    if (!nullToAbsent || finishedAtMs != null) {
      map['finished_at_ms'] = Variable<int>(finishedAtMs);
    }
    return map;
  }

  ContinuousSessionsCompanion toCompanion(bool nullToAbsent) {
    return ContinuousSessionsCompanion(
      id: Value(id),
      startedAtMs: Value(startedAtMs),
      finishedAtMs: finishedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAtMs),
    );
  }

  factory ContinuousSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContinuousSession(
      id: serializer.fromJson<int>(json['id']),
      startedAtMs: serializer.fromJson<int>(json['startedAtMs']),
      finishedAtMs: serializer.fromJson<int?>(json['finishedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAtMs': serializer.toJson<int>(startedAtMs),
      'finishedAtMs': serializer.toJson<int?>(finishedAtMs),
    };
  }

  ContinuousSession copyWith({
    int? id,
    int? startedAtMs,
    Value<int?> finishedAtMs = const Value.absent(),
  }) => ContinuousSession(
    id: id ?? this.id,
    startedAtMs: startedAtMs ?? this.startedAtMs,
    finishedAtMs: finishedAtMs.present ? finishedAtMs.value : this.finishedAtMs,
  );
  ContinuousSession copyWithCompanion(ContinuousSessionsCompanion data) {
    return ContinuousSession(
      id: data.id.present ? data.id.value : this.id,
      startedAtMs: data.startedAtMs.present
          ? data.startedAtMs.value
          : this.startedAtMs,
      finishedAtMs: data.finishedAtMs.present
          ? data.finishedAtMs.value
          : this.finishedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContinuousSession(')
          ..write('id: $id, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('finishedAtMs: $finishedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, startedAtMs, finishedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContinuousSession &&
          other.id == this.id &&
          other.startedAtMs == this.startedAtMs &&
          other.finishedAtMs == this.finishedAtMs);
}

class ContinuousSessionsCompanion extends UpdateCompanion<ContinuousSession> {
  final Value<int> id;
  final Value<int> startedAtMs;
  final Value<int?> finishedAtMs;
  const ContinuousSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAtMs = const Value.absent(),
    this.finishedAtMs = const Value.absent(),
  });
  ContinuousSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int startedAtMs,
    this.finishedAtMs = const Value.absent(),
  }) : startedAtMs = Value(startedAtMs);
  static Insertable<ContinuousSession> custom({
    Expression<int>? id,
    Expression<int>? startedAtMs,
    Expression<int>? finishedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAtMs != null) 'started_at_ms': startedAtMs,
      if (finishedAtMs != null) 'finished_at_ms': finishedAtMs,
    });
  }

  ContinuousSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? startedAtMs,
    Value<int?>? finishedAtMs,
  }) {
    return ContinuousSessionsCompanion(
      id: id ?? this.id,
      startedAtMs: startedAtMs ?? this.startedAtMs,
      finishedAtMs: finishedAtMs ?? this.finishedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAtMs.present) {
      map['started_at_ms'] = Variable<int>(startedAtMs.value);
    }
    if (finishedAtMs.present) {
      map['finished_at_ms'] = Variable<int>(finishedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContinuousSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('finishedAtMs: $finishedAtMs')
          ..write(')'))
        .toString();
  }
}

class $ScanRecordsTable extends ScanRecords
    with TableInfo<$ScanRecordsTable, ScanRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<String> rawValue = GeneratedColumn<String>(
    'raw_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formatKeyMeta = const VerificationMeta(
    'formatKey',
  );
  @override
  late final GeneratedColumn<String> formatKey = GeneratedColumn<String>(
    'format_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parserVersionMeta = const VerificationMeta(
    'parserVersion',
  );
  @override
  late final GeneratedColumn<int> parserVersion = GeneratedColumn<int>(
    'parser_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _batchSessionIdMeta = const VerificationMeta(
    'batchSessionId',
  );
  @override
  late final GeneratedColumn<int> batchSessionId = GeneratedColumn<int>(
    'batch_session_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES continuous_sessions (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawValue,
    formatKey,
    contentType,
    source,
    createdAtMs,
    isFavorite,
    note,
    parserVersion,
    batchSessionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scans';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    } else if (isInserting) {
      context.missing(_rawValueMeta);
    }
    if (data.containsKey('format_key')) {
      context.handle(
        _formatKeyMeta,
        formatKey.isAcceptableOrUnknown(data['format_key']!, _formatKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_formatKeyMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('parser_version')) {
      context.handle(
        _parserVersionMeta,
        parserVersion.isAcceptableOrUnknown(
          data['parser_version']!,
          _parserVersionMeta,
        ),
      );
    }
    if (data.containsKey('batch_session_id')) {
      context.handle(
        _batchSessionIdMeta,
        batchSessionId.isAcceptableOrUnknown(
          data['batch_session_id']!,
          _batchSessionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_value'],
      )!,
      formatKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format_key'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      parserVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parser_version'],
      )!,
      batchSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}batch_session_id'],
      ),
    );
  }

  @override
  $ScanRecordsTable createAlias(String alias) {
    return $ScanRecordsTable(attachedDatabase, alias);
  }
}

class ScanRecord extends DataClass implements Insertable<ScanRecord> {
  final int id;
  final String rawValue;
  final String formatKey;
  final String contentType;
  final String source;
  final int createdAtMs;
  final bool isFavorite;
  final String? note;
  final int parserVersion;
  final int? batchSessionId;
  const ScanRecord({
    required this.id,
    required this.rawValue,
    required this.formatKey,
    required this.contentType,
    required this.source,
    required this.createdAtMs,
    required this.isFavorite,
    this.note,
    required this.parserVersion,
    this.batchSessionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['raw_value'] = Variable<String>(rawValue);
    map['format_key'] = Variable<String>(formatKey);
    map['content_type'] = Variable<String>(contentType);
    map['source'] = Variable<String>(source);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['parser_version'] = Variable<int>(parserVersion);
    if (!nullToAbsent || batchSessionId != null) {
      map['batch_session_id'] = Variable<int>(batchSessionId);
    }
    return map;
  }

  ScanRecordsCompanion toCompanion(bool nullToAbsent) {
    return ScanRecordsCompanion(
      id: Value(id),
      rawValue: Value(rawValue),
      formatKey: Value(formatKey),
      contentType: Value(contentType),
      source: Value(source),
      createdAtMs: Value(createdAtMs),
      isFavorite: Value(isFavorite),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      parserVersion: Value(parserVersion),
      batchSessionId: batchSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(batchSessionId),
    );
  }

  factory ScanRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanRecord(
      id: serializer.fromJson<int>(json['id']),
      rawValue: serializer.fromJson<String>(json['rawValue']),
      formatKey: serializer.fromJson<String>(json['formatKey']),
      contentType: serializer.fromJson<String>(json['contentType']),
      source: serializer.fromJson<String>(json['source']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      note: serializer.fromJson<String?>(json['note']),
      parserVersion: serializer.fromJson<int>(json['parserVersion']),
      batchSessionId: serializer.fromJson<int?>(json['batchSessionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rawValue': serializer.toJson<String>(rawValue),
      'formatKey': serializer.toJson<String>(formatKey),
      'contentType': serializer.toJson<String>(contentType),
      'source': serializer.toJson<String>(source),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'note': serializer.toJson<String?>(note),
      'parserVersion': serializer.toJson<int>(parserVersion),
      'batchSessionId': serializer.toJson<int?>(batchSessionId),
    };
  }

  ScanRecord copyWith({
    int? id,
    String? rawValue,
    String? formatKey,
    String? contentType,
    String? source,
    int? createdAtMs,
    bool? isFavorite,
    Value<String?> note = const Value.absent(),
    int? parserVersion,
    Value<int?> batchSessionId = const Value.absent(),
  }) => ScanRecord(
    id: id ?? this.id,
    rawValue: rawValue ?? this.rawValue,
    formatKey: formatKey ?? this.formatKey,
    contentType: contentType ?? this.contentType,
    source: source ?? this.source,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    isFavorite: isFavorite ?? this.isFavorite,
    note: note.present ? note.value : this.note,
    parserVersion: parserVersion ?? this.parserVersion,
    batchSessionId: batchSessionId.present
        ? batchSessionId.value
        : this.batchSessionId,
  );
  ScanRecord copyWithCompanion(ScanRecordsCompanion data) {
    return ScanRecord(
      id: data.id.present ? data.id.value : this.id,
      rawValue: data.rawValue.present ? data.rawValue.value : this.rawValue,
      formatKey: data.formatKey.present ? data.formatKey.value : this.formatKey,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      source: data.source.present ? data.source.value : this.source,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      note: data.note.present ? data.note.value : this.note,
      parserVersion: data.parserVersion.present
          ? data.parserVersion.value
          : this.parserVersion,
      batchSessionId: data.batchSessionId.present
          ? data.batchSessionId.value
          : this.batchSessionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanRecord(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('formatKey: $formatKey, ')
          ..write('contentType: $contentType, ')
          ..write('source: $source, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('note: $note, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('batchSessionId: $batchSessionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawValue,
    formatKey,
    contentType,
    source,
    createdAtMs,
    isFavorite,
    note,
    parserVersion,
    batchSessionId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanRecord &&
          other.id == this.id &&
          other.rawValue == this.rawValue &&
          other.formatKey == this.formatKey &&
          other.contentType == this.contentType &&
          other.source == this.source &&
          other.createdAtMs == this.createdAtMs &&
          other.isFavorite == this.isFavorite &&
          other.note == this.note &&
          other.parserVersion == this.parserVersion &&
          other.batchSessionId == this.batchSessionId);
}

class ScanRecordsCompanion extends UpdateCompanion<ScanRecord> {
  final Value<int> id;
  final Value<String> rawValue;
  final Value<String> formatKey;
  final Value<String> contentType;
  final Value<String> source;
  final Value<int> createdAtMs;
  final Value<bool> isFavorite;
  final Value<String?> note;
  final Value<int> parserVersion;
  final Value<int?> batchSessionId;
  const ScanRecordsCompanion({
    this.id = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.formatKey = const Value.absent(),
    this.contentType = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.note = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.batchSessionId = const Value.absent(),
  });
  ScanRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String rawValue,
    required String formatKey,
    required String contentType,
    required String source,
    required int createdAtMs,
    this.isFavorite = const Value.absent(),
    this.note = const Value.absent(),
    this.parserVersion = const Value.absent(),
    this.batchSessionId = const Value.absent(),
  }) : rawValue = Value(rawValue),
       formatKey = Value(formatKey),
       contentType = Value(contentType),
       source = Value(source),
       createdAtMs = Value(createdAtMs);
  static Insertable<ScanRecord> custom({
    Expression<int>? id,
    Expression<String>? rawValue,
    Expression<String>? formatKey,
    Expression<String>? contentType,
    Expression<String>? source,
    Expression<int>? createdAtMs,
    Expression<bool>? isFavorite,
    Expression<String>? note,
    Expression<int>? parserVersion,
    Expression<int>? batchSessionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawValue != null) 'raw_value': rawValue,
      if (formatKey != null) 'format_key': formatKey,
      if (contentType != null) 'content_type': contentType,
      if (source != null) 'source': source,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (note != null) 'note': note,
      if (parserVersion != null) 'parser_version': parserVersion,
      if (batchSessionId != null) 'batch_session_id': batchSessionId,
    });
  }

  ScanRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? rawValue,
    Value<String>? formatKey,
    Value<String>? contentType,
    Value<String>? source,
    Value<int>? createdAtMs,
    Value<bool>? isFavorite,
    Value<String?>? note,
    Value<int>? parserVersion,
    Value<int?>? batchSessionId,
  }) {
    return ScanRecordsCompanion(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      formatKey: formatKey ?? this.formatKey,
      contentType: contentType ?? this.contentType,
      source: source ?? this.source,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      isFavorite: isFavorite ?? this.isFavorite,
      note: note ?? this.note,
      parserVersion: parserVersion ?? this.parserVersion,
      batchSessionId: batchSessionId ?? this.batchSessionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<String>(rawValue.value);
    }
    if (formatKey.present) {
      map['format_key'] = Variable<String>(formatKey.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (parserVersion.present) {
      map['parser_version'] = Variable<int>(parserVersion.value);
    }
    if (batchSessionId.present) {
      map['batch_session_id'] = Variable<int>(batchSessionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanRecordsCompanion(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('formatKey: $formatKey, ')
          ..write('contentType: $contentType, ')
          ..write('source: $source, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('note: $note, ')
          ..write('parserVersion: $parserVersion, ')
          ..write('batchSessionId: $batchSessionId')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String name;
  const Tag({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(id: Value(id), name: Value(name));
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Tag copyWith({int? id, String? name}) =>
      Tag(id: id ?? this.id, name: name ?? this.name);
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag && other.id == this.id && other.name == this.name);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TagsCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TagsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TagsCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ScanTagsTable extends ScanTags with TableInfo<$ScanTagsTable, ScanTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scanIdMeta = const VerificationMeta('scanId');
  @override
  late final GeneratedColumn<int> scanId = GeneratedColumn<int>(
    'scan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES scans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [scanId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scan_id')) {
      context.handle(
        _scanIdMeta,
        scanId.isAcceptableOrUnknown(data['scan_id']!, _scanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_scanIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scanId, tagId};
  @override
  ScanTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanTag(
      scanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scan_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $ScanTagsTable createAlias(String alias) {
    return $ScanTagsTable(attachedDatabase, alias);
  }
}

class ScanTag extends DataClass implements Insertable<ScanTag> {
  final int scanId;
  final int tagId;
  const ScanTag({required this.scanId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scan_id'] = Variable<int>(scanId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  ScanTagsCompanion toCompanion(bool nullToAbsent) {
    return ScanTagsCompanion(scanId: Value(scanId), tagId: Value(tagId));
  }

  factory ScanTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanTag(
      scanId: serializer.fromJson<int>(json['scanId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scanId': serializer.toJson<int>(scanId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  ScanTag copyWith({int? scanId, int? tagId}) =>
      ScanTag(scanId: scanId ?? this.scanId, tagId: tagId ?? this.tagId);
  ScanTag copyWithCompanion(ScanTagsCompanion data) {
    return ScanTag(
      scanId: data.scanId.present ? data.scanId.value : this.scanId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanTag(')
          ..write('scanId: $scanId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(scanId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanTag &&
          other.scanId == this.scanId &&
          other.tagId == this.tagId);
}

class ScanTagsCompanion extends UpdateCompanion<ScanTag> {
  final Value<int> scanId;
  final Value<int> tagId;
  final Value<int> rowid;
  const ScanTagsCompanion({
    this.scanId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanTagsCompanion.insert({
    required int scanId,
    required int tagId,
    this.rowid = const Value.absent(),
  }) : scanId = Value(scanId),
       tagId = Value(tagId);
  static Insertable<ScanTag> custom({
    Expression<int>? scanId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (scanId != null) 'scan_id': scanId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanTagsCompanion copyWith({
    Value<int>? scanId,
    Value<int>? tagId,
    Value<int>? rowid,
  }) {
    return ScanTagsCompanion(
      scanId: scanId ?? this.scanId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scanId.present) {
      map['scan_id'] = Variable<int>(scanId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanTagsCompanion(')
          ..write('scanId: $scanId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SearchEnginesTable extends SearchEngines
    with TableInfo<$SearchEnginesTable, SearchEngine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SearchEnginesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateMeta = const VerificationMeta(
    'template',
  );
  @override
  late final GeneratedColumn<String> template = GeneratedColumn<String>(
    'template',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    template,
    isActive,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'search_engines';
  @override
  VerificationContext validateIntegrity(
    Insertable<SearchEngine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('template')) {
      context.handle(
        _templateMeta,
        template.isAcceptableOrUnknown(data['template']!, _templateMeta),
      );
    } else if (isInserting) {
      context.missing(_templateMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SearchEngine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SearchEngine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      template: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $SearchEnginesTable createAlias(String alias) {
    return $SearchEnginesTable(attachedDatabase, alias);
  }
}

class SearchEngine extends DataClass implements Insertable<SearchEngine> {
  final int id;
  final String name;
  final String template;
  final bool isActive;
  final int sortOrder;
  const SearchEngine({
    required this.id,
    required this.name,
    required this.template,
    required this.isActive,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['template'] = Variable<String>(template);
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  SearchEnginesCompanion toCompanion(bool nullToAbsent) {
    return SearchEnginesCompanion(
      id: Value(id),
      name: Value(name),
      template: Value(template),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
    );
  }

  factory SearchEngine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SearchEngine(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      template: serializer.fromJson<String>(json['template']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'template': serializer.toJson<String>(template),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  SearchEngine copyWith({
    int? id,
    String? name,
    String? template,
    bool? isActive,
    int? sortOrder,
  }) => SearchEngine(
    id: id ?? this.id,
    name: name ?? this.name,
    template: template ?? this.template,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  SearchEngine copyWithCompanion(SearchEnginesCompanion data) {
    return SearchEngine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      template: data.template.present ? data.template.value : this.template,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SearchEngine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('template: $template, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, template, isActive, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchEngine &&
          other.id == this.id &&
          other.name == this.name &&
          other.template == this.template &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder);
}

class SearchEnginesCompanion extends UpdateCompanion<SearchEngine> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> template;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  const SearchEnginesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.template = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  SearchEnginesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String template,
    this.isActive = const Value.absent(),
    required int sortOrder,
  }) : name = Value(name),
       template = Value(template),
       sortOrder = Value(sortOrder);
  static Insertable<SearchEngine> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? template,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (template != null) 'template': template,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  SearchEnginesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? template,
    Value<bool>? isActive,
    Value<int>? sortOrder,
  }) {
    return SearchEnginesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      template: template ?? this.template,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (template.present) {
      map['template'] = Variable<String>(template.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SearchEnginesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('template: $template, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BootstrapProbesTable bootstrapProbes = $BootstrapProbesTable(
    this,
  );
  late final $ContinuousSessionsTable continuousSessions =
      $ContinuousSessionsTable(this);
  late final $ScanRecordsTable scanRecords = $ScanRecordsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $ScanTagsTable scanTags = $ScanTagsTable(this);
  late final $SearchEnginesTable searchEngines = $SearchEnginesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bootstrapProbes,
    continuousSessions,
    scanRecords,
    tags,
    scanTags,
    searchEngines,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'continuous_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scans', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scan_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scan_tags', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BootstrapProbesTableCreateCompanionBuilder =
    BootstrapProbesCompanion Function({Value<int> id, required String marker});
typedef $$BootstrapProbesTableUpdateCompanionBuilder =
    BootstrapProbesCompanion Function({Value<int> id, Value<String> marker});

class $$BootstrapProbesTableFilterComposer
    extends Composer<_$AppDatabase, $BootstrapProbesTable> {
  $$BootstrapProbesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marker => $composableBuilder(
    column: $table.marker,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BootstrapProbesTableOrderingComposer
    extends Composer<_$AppDatabase, $BootstrapProbesTable> {
  $$BootstrapProbesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marker => $composableBuilder(
    column: $table.marker,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BootstrapProbesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BootstrapProbesTable> {
  $$BootstrapProbesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get marker =>
      $composableBuilder(column: $table.marker, builder: (column) => column);
}

class $$BootstrapProbesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BootstrapProbesTable,
          BootstrapProbe,
          $$BootstrapProbesTableFilterComposer,
          $$BootstrapProbesTableOrderingComposer,
          $$BootstrapProbesTableAnnotationComposer,
          $$BootstrapProbesTableCreateCompanionBuilder,
          $$BootstrapProbesTableUpdateCompanionBuilder,
          (
            BootstrapProbe,
            BaseReferences<
              _$AppDatabase,
              $BootstrapProbesTable,
              BootstrapProbe
            >,
          ),
          BootstrapProbe,
          PrefetchHooks Function()
        > {
  $$BootstrapProbesTableTableManager(
    _$AppDatabase db,
    $BootstrapProbesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BootstrapProbesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BootstrapProbesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BootstrapProbesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> marker = const Value.absent(),
          }) => BootstrapProbesCompanion(id: id, marker: marker),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String marker,
          }) => BootstrapProbesCompanion.insert(id: id, marker: marker),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BootstrapProbesTable, BootstrapProbe>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BootstrapProbesTable,
                    BootstrapProbe
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BootstrapProbesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BootstrapProbesTable,
      BootstrapProbe,
      $$BootstrapProbesTableFilterComposer,
      $$BootstrapProbesTableOrderingComposer,
      $$BootstrapProbesTableAnnotationComposer,
      $$BootstrapProbesTableCreateCompanionBuilder,
      $$BootstrapProbesTableUpdateCompanionBuilder,
      (
        BootstrapProbe,
        BaseReferences<_$AppDatabase, $BootstrapProbesTable, BootstrapProbe>,
      ),
      BootstrapProbe,
      PrefetchHooks Function()
    >;
typedef $$ContinuousSessionsTableCreateCompanionBuilder =
    ContinuousSessionsCompanion Function({
      Value<int> id,
      required int startedAtMs,
      Value<int?> finishedAtMs,
    });
typedef $$ContinuousSessionsTableUpdateCompanionBuilder =
    ContinuousSessionsCompanion Function({
      Value<int> id,
      Value<int> startedAtMs,
      Value<int?> finishedAtMs,
    });

final class $$ContinuousSessionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ContinuousSessionsTable,
          ContinuousSession
        > {
  $$ContinuousSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ScanRecordsTable, List<ScanRecord>>
  _scanRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scanRecords,
    aliasName: 'continuous_sessions__id__scans__batch_session_id',
  );

  $$ScanRecordsTableProcessedTableManager get scanRecordsRefs {
    final manager = $$ScanRecordsTableTableManager(
      $_db,
      $_db.scanRecords,
    ).filter((f) => f.batchSessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scanRecordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContinuousSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ContinuousSessionsTable> {
  $$ContinuousSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get finishedAtMs => $composableBuilder(
    column: $table.finishedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scanRecordsRefs(
    Expression<bool> Function($$ScanRecordsTableFilterComposer f) f,
  ) {
    final $$ScanRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanRecords,
      getReferencedColumn: (t) => t.batchSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanRecordsTableFilterComposer(
            $db: $db,
            $table: $db.scanRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContinuousSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContinuousSessionsTable> {
  $$ContinuousSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get finishedAtMs => $composableBuilder(
    column: $table.finishedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContinuousSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContinuousSessionsTable> {
  $$ContinuousSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get finishedAtMs => $composableBuilder(
    column: $table.finishedAtMs,
    builder: (column) => column,
  );

  Expression<T> scanRecordsRefs<T extends Object>(
    Expression<T> Function($$ScanRecordsTableAnnotationComposer a) f,
  ) {
    final $$ScanRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanRecords,
      getReferencedColumn: (t) => t.batchSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContinuousSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContinuousSessionsTable,
          ContinuousSession,
          $$ContinuousSessionsTableFilterComposer,
          $$ContinuousSessionsTableOrderingComposer,
          $$ContinuousSessionsTableAnnotationComposer,
          $$ContinuousSessionsTableCreateCompanionBuilder,
          $$ContinuousSessionsTableUpdateCompanionBuilder,
          (ContinuousSession, $$ContinuousSessionsTableReferences),
          ContinuousSession,
          PrefetchHooks Function({bool scanRecordsRefs})
        > {
  $$ContinuousSessionsTableTableManager(
    _$AppDatabase db,
    $ContinuousSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContinuousSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContinuousSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContinuousSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> startedAtMs = const Value.absent(),
                Value<int?> finishedAtMs = const Value.absent(),
              }) => ContinuousSessionsCompanion(
                id: id,
                startedAtMs: startedAtMs,
                finishedAtMs: finishedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int startedAtMs,
                Value<int?> finishedAtMs = const Value.absent(),
              }) => ContinuousSessionsCompanion.insert(
                id: id,
                startedAtMs: startedAtMs,
                finishedAtMs: finishedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ContinuousSessionsTable, ContinuousSession>(
                    table,
                  ),
                  $$ContinuousSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scanRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (scanRecordsRefs) db.scanRecords],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scanRecordsRefs)
                    await $_getPrefetchedData<
                      ContinuousSession,
                      $ContinuousSessionsTable,
                      ScanRecord
                    >(
                      currentTable: table,
                      referencedTable: $$ContinuousSessionsTableReferences
                          ._scanRecordsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ContinuousSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).scanRecordsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.batchSessionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ContinuousSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContinuousSessionsTable,
      ContinuousSession,
      $$ContinuousSessionsTableFilterComposer,
      $$ContinuousSessionsTableOrderingComposer,
      $$ContinuousSessionsTableAnnotationComposer,
      $$ContinuousSessionsTableCreateCompanionBuilder,
      $$ContinuousSessionsTableUpdateCompanionBuilder,
      (ContinuousSession, $$ContinuousSessionsTableReferences),
      ContinuousSession,
      PrefetchHooks Function({bool scanRecordsRefs})
    >;
typedef $$ScanRecordsTableCreateCompanionBuilder =
    ScanRecordsCompanion Function({
      Value<int> id,
      required String rawValue,
      required String formatKey,
      required String contentType,
      required String source,
      required int createdAtMs,
      Value<bool> isFavorite,
      Value<String?> note,
      Value<int> parserVersion,
      Value<int?> batchSessionId,
    });
typedef $$ScanRecordsTableUpdateCompanionBuilder =
    ScanRecordsCompanion Function({
      Value<int> id,
      Value<String> rawValue,
      Value<String> formatKey,
      Value<String> contentType,
      Value<String> source,
      Value<int> createdAtMs,
      Value<bool> isFavorite,
      Value<String?> note,
      Value<int> parserVersion,
      Value<int?> batchSessionId,
    });

final class $$ScanRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $ScanRecordsTable, ScanRecord> {
  $$ScanRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ContinuousSessionsTable _batchSessionIdTable(_$AppDatabase db) => db
      .continuousSessions
      .createAlias('scans__batch_session_id__continuous_sessions__id');

  $$ContinuousSessionsTableProcessedTableManager? get batchSessionId {
    final $_column = $_itemColumn<int>('batch_session_id');
    if ($_column == null) return null;
    final manager = $$ContinuousSessionsTableTableManager(
      $_db,
      $_db.continuousSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ScanTagsTable, List<ScanTag>> _scanTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scanTags,
    aliasName: 'scans__id__scan_tags__scan_id',
  );

  $$ScanTagsTableProcessedTableManager get scanTagsRefs {
    final manager = $$ScanTagsTableTableManager(
      $_db,
      $_db.scanTags,
    ).filter((f) => f.scanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scanTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScanRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formatKey => $composableBuilder(
    column: $table.formatKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnFilters(column),
  );

  $$ContinuousSessionsTableFilterComposer get batchSessionId {
    final $$ContinuousSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchSessionId,
      referencedTable: $db.continuousSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContinuousSessionsTableFilterComposer(
            $db: $db,
            $table: $db.continuousSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> scanTagsRefs(
    Expression<bool> Function($$ScanTagsTableFilterComposer f) f,
  ) {
    final $$ScanTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanTags,
      getReferencedColumn: (t) => t.scanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanTagsTableFilterComposer(
            $db: $db,
            $table: $db.scanTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScanRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formatKey => $composableBuilder(
    column: $table.formatKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContinuousSessionsTableOrderingComposer get batchSessionId {
    final $$ContinuousSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchSessionId,
      referencedTable: $db.continuousSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContinuousSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.continuousSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumn<String> get formatKey =>
      $composableBuilder(column: $table.formatKey, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get parserVersion => $composableBuilder(
    column: $table.parserVersion,
    builder: (column) => column,
  );

  $$ContinuousSessionsTableAnnotationComposer get batchSessionId {
    final $$ContinuousSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.batchSessionId,
          referencedTable: $db.continuousSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ContinuousSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.continuousSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> scanTagsRefs<T extends Object>(
    Expression<T> Function($$ScanTagsTableAnnotationComposer a) f,
  ) {
    final $$ScanTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanTags,
      getReferencedColumn: (t) => t.scanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScanRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanRecordsTable,
          ScanRecord,
          $$ScanRecordsTableFilterComposer,
          $$ScanRecordsTableOrderingComposer,
          $$ScanRecordsTableAnnotationComposer,
          $$ScanRecordsTableCreateCompanionBuilder,
          $$ScanRecordsTableUpdateCompanionBuilder,
          (ScanRecord, $$ScanRecordsTableReferences),
          ScanRecord,
          PrefetchHooks Function({bool batchSessionId, bool scanTagsRefs})
        > {
  $$ScanRecordsTableTableManager(_$AppDatabase db, $ScanRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> rawValue = const Value.absent(),
                Value<String> formatKey = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> parserVersion = const Value.absent(),
                Value<int?> batchSessionId = const Value.absent(),
              }) => ScanRecordsCompanion(
                id: id,
                rawValue: rawValue,
                formatKey: formatKey,
                contentType: contentType,
                source: source,
                createdAtMs: createdAtMs,
                isFavorite: isFavorite,
                note: note,
                parserVersion: parserVersion,
                batchSessionId: batchSessionId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String rawValue,
                required String formatKey,
                required String contentType,
                required String source,
                required int createdAtMs,
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> parserVersion = const Value.absent(),
                Value<int?> batchSessionId = const Value.absent(),
              }) => ScanRecordsCompanion.insert(
                id: id,
                rawValue: rawValue,
                formatKey: formatKey,
                contentType: contentType,
                source: source,
                createdAtMs: createdAtMs,
                isFavorite: isFavorite,
                note: note,
                parserVersion: parserVersion,
                batchSessionId: batchSessionId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScanRecordsTable, ScanRecord>(table),
                  $$ScanRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({batchSessionId = false, scanTagsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (scanTagsRefs) db.scanTags],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (batchSessionId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.batchSessionId,
                            referencedTable: $$ScanRecordsTableReferences
                                ._batchSessionIdTable(db),
                            referencedColumn: $$ScanRecordsTableReferences
                                ._batchSessionIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (scanTagsRefs)
                        await $_getPrefetchedData<
                          ScanRecord,
                          $ScanRecordsTable,
                          ScanTag
                        >(
                          currentTable: table,
                          referencedTable: $$ScanRecordsTableReferences
                              ._scanTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScanRecordsTableReferences(
                                db,
                                table,
                                p0,
                              ).scanTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scanId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ScanRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanRecordsTable,
      ScanRecord,
      $$ScanRecordsTableFilterComposer,
      $$ScanRecordsTableOrderingComposer,
      $$ScanRecordsTableAnnotationComposer,
      $$ScanRecordsTableCreateCompanionBuilder,
      $$ScanRecordsTableUpdateCompanionBuilder,
      (ScanRecord, $$ScanRecordsTableReferences),
      ScanRecord,
      PrefetchHooks Function({bool batchSessionId, bool scanTagsRefs})
    >;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScanTagsTable, List<ScanTag>> _scanTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.scanTags,
    aliasName: 'tags__id__scan_tags__tag_id',
  );

  $$ScanTagsTableProcessedTableManager get scanTagsRefs {
    final manager = $$ScanTagsTableTableManager(
      $_db,
      $_db.scanTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scanTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scanTagsRefs(
    Expression<bool> Function($$ScanTagsTableFilterComposer f) f,
  ) {
    final $$ScanTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanTagsTableFilterComposer(
            $db: $db,
            $table: $db.scanTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> scanTagsRefs<T extends Object>(
    Expression<T> Function($$ScanTagsTableAnnotationComposer a) f,
  ) {
    final $$ScanTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool scanTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => TagsCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => TagsCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scanTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (scanTagsRefs) db.scanTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scanTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, ScanTag>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences._scanTagsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).scanTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool scanTagsRefs})
    >;
typedef $$ScanTagsTableCreateCompanionBuilder = ScanTagsCompanion Function({
  required int scanId,
  required int tagId,
  Value<int> rowid,
});
typedef $$ScanTagsTableUpdateCompanionBuilder = ScanTagsCompanion Function({
  Value<int> scanId,
  Value<int> tagId,
  Value<int> rowid,
});

final class $$ScanTagsTableReferences
    extends BaseReferences<_$AppDatabase, $ScanTagsTable, ScanTag> {
  $$ScanTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ScanRecordsTable _scanIdTable(_$AppDatabase db) =>
      db.scanRecords.createAlias('scan_tags__scan_id__scans__id');

  $$ScanRecordsTableProcessedTableManager get scanId {
    final $_column = $_itemColumn<int>('scan_id')!;

    final manager = $$ScanRecordsTableTableManager(
      $_db,
      $_db.scanRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('scan_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScanTagsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanTagsTable> {
  $$ScanTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ScanRecordsTableFilterComposer get scanId {
    final $$ScanRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scanRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanRecordsTableFilterComposer(
            $db: $db,
            $table: $db.scanRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanTagsTable> {
  $$ScanTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ScanRecordsTableOrderingComposer get scanId {
    final $$ScanRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scanRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.scanRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanTagsTable> {
  $$ScanTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ScanRecordsTableAnnotationComposer get scanId {
    final $$ScanRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scanId,
      referencedTable: $db.scanRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanTagsTable,
          ScanTag,
          $$ScanTagsTableFilterComposer,
          $$ScanTagsTableOrderingComposer,
          $$ScanTagsTableAnnotationComposer,
          $$ScanTagsTableCreateCompanionBuilder,
          $$ScanTagsTableUpdateCompanionBuilder,
          (ScanTag, $$ScanTagsTableReferences),
          ScanTag,
          PrefetchHooks Function({bool scanId, bool tagId})
        > {
  $$ScanTagsTableTableManager(_$AppDatabase db, $ScanTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> scanId = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => ScanTagsCompanion(scanId: scanId, tagId: tagId, rowid: rowid),
          createCompanionCallback:
              ({
                required int scanId,
                required int tagId,
                Value<int> rowid = const Value.absent(),
              }) => ScanTagsCompanion.insert(
                scanId: scanId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScanTagsTable, ScanTag>(table),
                  $$ScanTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scanId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (scanId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.scanId,
                        referencedTable: $$ScanTagsTableReferences._scanIdTable(
                          db,
                        ),
                        referencedColumn: $$ScanTagsTableReferences
                            ._scanIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (tagId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.tagId,
                        referencedTable: $$ScanTagsTableReferences._tagIdTable(
                          db,
                        ),
                        referencedColumn: $$ScanTagsTableReferences
                            ._tagIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScanTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanTagsTable,
      ScanTag,
      $$ScanTagsTableFilterComposer,
      $$ScanTagsTableOrderingComposer,
      $$ScanTagsTableAnnotationComposer,
      $$ScanTagsTableCreateCompanionBuilder,
      $$ScanTagsTableUpdateCompanionBuilder,
      (ScanTag, $$ScanTagsTableReferences),
      ScanTag,
      PrefetchHooks Function({bool scanId, bool tagId})
    >;
typedef $$SearchEnginesTableCreateCompanionBuilder =
    SearchEnginesCompanion Function({
      Value<int> id,
      required String name,
      required String template,
      Value<bool> isActive,
      required int sortOrder,
    });
typedef $$SearchEnginesTableUpdateCompanionBuilder =
    SearchEnginesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> template,
      Value<bool> isActive,
      Value<int> sortOrder,
    });

class $$SearchEnginesTableFilterComposer
    extends Composer<_$AppDatabase, $SearchEnginesTable> {
  $$SearchEnginesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SearchEnginesTableOrderingComposer
    extends Composer<_$AppDatabase, $SearchEnginesTable> {
  $$SearchEnginesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SearchEnginesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SearchEnginesTable> {
  $$SearchEnginesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get template =>
      $composableBuilder(column: $table.template, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$SearchEnginesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SearchEnginesTable,
          SearchEngine,
          $$SearchEnginesTableFilterComposer,
          $$SearchEnginesTableOrderingComposer,
          $$SearchEnginesTableAnnotationComposer,
          $$SearchEnginesTableCreateCompanionBuilder,
          $$SearchEnginesTableUpdateCompanionBuilder,
          (
            SearchEngine,
            BaseReferences<_$AppDatabase, $SearchEnginesTable, SearchEngine>,
          ),
          SearchEngine,
          PrefetchHooks Function()
        > {
  $$SearchEnginesTableTableManager(_$AppDatabase db, $SearchEnginesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SearchEnginesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SearchEnginesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SearchEnginesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> template = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => SearchEnginesCompanion(
                id: id,
                name: name,
                template: template,
                isActive: isActive,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String template,
                Value<bool> isActive = const Value.absent(),
                required int sortOrder,
              }) => SearchEnginesCompanion.insert(
                id: id,
                name: name,
                template: template,
                isActive: isActive,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SearchEnginesTable, SearchEngine>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SearchEnginesTable,
                    SearchEngine
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SearchEnginesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SearchEnginesTable,
      SearchEngine,
      $$SearchEnginesTableFilterComposer,
      $$SearchEnginesTableOrderingComposer,
      $$SearchEnginesTableAnnotationComposer,
      $$SearchEnginesTableCreateCompanionBuilder,
      $$SearchEnginesTableUpdateCompanionBuilder,
      (
        SearchEngine,
        BaseReferences<_$AppDatabase, $SearchEnginesTable, SearchEngine>,
      ),
      SearchEngine,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BootstrapProbesTableTableManager get bootstrapProbes =>
      $$BootstrapProbesTableTableManager(_db, _db.bootstrapProbes);
  $$ContinuousSessionsTableTableManager get continuousSessions =>
      $$ContinuousSessionsTableTableManager(_db, _db.continuousSessions);
  $$ScanRecordsTableTableManager get scanRecords =>
      $$ScanRecordsTableTableManager(_db, _db.scanRecords);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$ScanTagsTableTableManager get scanTags =>
      $$ScanTagsTableTableManager(_db, _db.scanTags);
  $$SearchEnginesTableTableManager get searchEngines =>
      $$SearchEnginesTableTableManager(_db, _db.searchEngines);
}
