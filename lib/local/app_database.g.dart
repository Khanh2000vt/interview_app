// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RoomsTableTable extends RoomsTable
    with TableInfo<$RoomsTableTable, Rooms> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jobMeta = const VerificationMeta('job');
  @override
  late final GeneratedColumn<String> job = GeneratedColumn<String>(
    'job',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
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
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, job, level, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Rooms> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('job')) {
      context.handle(
        _jobMeta,
        job.isAcceptableOrUnknown(data['job']!, _jobMeta),
      );
    } else if (isInserting) {
      context.missing(_jobMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rooms map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rooms(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      job:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}job'],
          )!,
      level:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}level'],
          )!,
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $RoomsTableTable createAlias(String alias) {
    return $RoomsTableTable(attachedDatabase, alias);
  }
}

class Rooms extends DataClass implements Insertable<Rooms> {
  final String id;
  final String job;
  final String level;
  final bool isActive;
  final DateTime createdAt;
  const Rooms({
    required this.id,
    required this.job,
    required this.level,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['job'] = Variable<String>(job);
    map['level'] = Variable<String>(level);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RoomsTableCompanion toCompanion(bool nullToAbsent) {
    return RoomsTableCompanion(
      id: Value(id),
      job: Value(job),
      level: Value(level),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Rooms.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rooms(
      id: serializer.fromJson<String>(json['id']),
      job: serializer.fromJson<String>(json['job']),
      level: serializer.fromJson<String>(json['level']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'job': serializer.toJson<String>(job),
      'level': serializer.toJson<String>(level),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Rooms copyWith({
    String? id,
    String? job,
    String? level,
    bool? isActive,
    DateTime? createdAt,
  }) => Rooms(
    id: id ?? this.id,
    job: job ?? this.job,
    level: level ?? this.level,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Rooms copyWithCompanion(RoomsTableCompanion data) {
    return Rooms(
      id: data.id.present ? data.id.value : this.id,
      job: data.job.present ? data.job.value : this.job,
      level: data.level.present ? data.level.value : this.level,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Rooms(')
          ..write('id: $id, ')
          ..write('job: $job, ')
          ..write('level: $level, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, job, level, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rooms &&
          other.id == this.id &&
          other.job == this.job &&
          other.level == this.level &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class RoomsTableCompanion extends UpdateCompanion<Rooms> {
  final Value<String> id;
  final Value<String> job;
  final Value<String> level;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RoomsTableCompanion({
    this.id = const Value.absent(),
    this.job = const Value.absent(),
    this.level = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoomsTableCompanion.insert({
    required String id,
    required String job,
    required String level,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       job = Value(job),
       level = Value(level);
  static Insertable<Rooms> custom({
    Expression<String>? id,
    Expression<String>? job,
    Expression<String>? level,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (job != null) 'job': job,
      if (level != null) 'level': level,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoomsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? job,
    Value<String>? level,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RoomsTableCompanion(
      id: id ?? this.id,
      job: job ?? this.job,
      level: level ?? this.level,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (job.present) {
      map['job'] = Variable<String>(job.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsTableCompanion(')
          ..write('id: $id, ')
          ..write('job: $job, ')
          ..write('level: $level, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatsTableTable extends ChatsTable
    with TableInfo<$ChatsTableTable, Chats> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _idRoomMeta = const VerificationMeta('idRoom');
  @override
  late final GeneratedColumn<String> idRoom = GeneratedColumn<String>(
    'id_room',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rooms_table (id)',
    ),
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleMeta = const VerificationMeta('rule');
  @override
  late final GeneratedColumn<String> rule = GeneratedColumn<String>(
    'rule',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, idRoom, message, rule, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chats> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_room')) {
      context.handle(
        _idRoomMeta,
        idRoom.isAcceptableOrUnknown(data['id_room']!, _idRoomMeta),
      );
    } else if (isInserting) {
      context.missing(_idRoomMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('rule')) {
      context.handle(
        _ruleMeta,
        rule.isAcceptableOrUnknown(data['rule']!, _ruleMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chats map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chats(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      idRoom:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id_room'],
          )!,
      message:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}message'],
          )!,
      rule:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}rule'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $ChatsTableTable createAlias(String alias) {
    return $ChatsTableTable(attachedDatabase, alias);
  }
}

class Chats extends DataClass implements Insertable<Chats> {
  final int id;
  final String idRoom;
  final String message;
  final String rule;
  final DateTime createdAt;
  const Chats({
    required this.id,
    required this.idRoom,
    required this.message,
    required this.rule,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_room'] = Variable<String>(idRoom);
    map['message'] = Variable<String>(message);
    map['rule'] = Variable<String>(rule);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChatsTableCompanion toCompanion(bool nullToAbsent) {
    return ChatsTableCompanion(
      id: Value(id),
      idRoom: Value(idRoom),
      message: Value(message),
      rule: Value(rule),
      createdAt: Value(createdAt),
    );
  }

  factory Chats.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chats(
      id: serializer.fromJson<int>(json['id']),
      idRoom: serializer.fromJson<String>(json['idRoom']),
      message: serializer.fromJson<String>(json['message']),
      rule: serializer.fromJson<String>(json['rule']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idRoom': serializer.toJson<String>(idRoom),
      'message': serializer.toJson<String>(message),
      'rule': serializer.toJson<String>(rule),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Chats copyWith({
    int? id,
    String? idRoom,
    String? message,
    String? rule,
    DateTime? createdAt,
  }) => Chats(
    id: id ?? this.id,
    idRoom: idRoom ?? this.idRoom,
    message: message ?? this.message,
    rule: rule ?? this.rule,
    createdAt: createdAt ?? this.createdAt,
  );
  Chats copyWithCompanion(ChatsTableCompanion data) {
    return Chats(
      id: data.id.present ? data.id.value : this.id,
      idRoom: data.idRoom.present ? data.idRoom.value : this.idRoom,
      message: data.message.present ? data.message.value : this.message,
      rule: data.rule.present ? data.rule.value : this.rule,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chats(')
          ..write('id: $id, ')
          ..write('idRoom: $idRoom, ')
          ..write('message: $message, ')
          ..write('rule: $rule, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idRoom, message, rule, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chats &&
          other.id == this.id &&
          other.idRoom == this.idRoom &&
          other.message == this.message &&
          other.rule == this.rule &&
          other.createdAt == this.createdAt);
}

class ChatsTableCompanion extends UpdateCompanion<Chats> {
  final Value<int> id;
  final Value<String> idRoom;
  final Value<String> message;
  final Value<String> rule;
  final Value<DateTime> createdAt;
  const ChatsTableCompanion({
    this.id = const Value.absent(),
    this.idRoom = const Value.absent(),
    this.message = const Value.absent(),
    this.rule = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ChatsTableCompanion.insert({
    this.id = const Value.absent(),
    required String idRoom,
    required String message,
    required String rule,
    this.createdAt = const Value.absent(),
  }) : idRoom = Value(idRoom),
       message = Value(message),
       rule = Value(rule);
  static Insertable<Chats> custom({
    Expression<int>? id,
    Expression<String>? idRoom,
    Expression<String>? message,
    Expression<String>? rule,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idRoom != null) 'id_room': idRoom,
      if (message != null) 'message': message,
      if (rule != null) 'rule': rule,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ChatsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? idRoom,
    Value<String>? message,
    Value<String>? rule,
    Value<DateTime>? createdAt,
  }) {
    return ChatsTableCompanion(
      id: id ?? this.id,
      idRoom: idRoom ?? this.idRoom,
      message: message ?? this.message,
      rule: rule ?? this.rule,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idRoom.present) {
      map['id_room'] = Variable<String>(idRoom.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (rule.present) {
      map['rule'] = Variable<String>(rule.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsTableCompanion(')
          ..write('id: $id, ')
          ..write('idRoom: $idRoom, ')
          ..write('message: $message, ')
          ..write('rule: $rule, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RoomsTableTable roomsTable = $RoomsTableTable(this);
  late final $ChatsTableTable chatsTable = $ChatsTableTable(this);
  late final Index idxIdRoom = Index(
    'idx_idRoom',
    'CREATE INDEX idx_idRoom ON chats_table (id_room)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    roomsTable,
    chatsTable,
    idxIdRoom,
  ];
}

typedef $$RoomsTableTableCreateCompanionBuilder =
    RoomsTableCompanion Function({
      required String id,
      required String job,
      required String level,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$RoomsTableTableUpdateCompanionBuilder =
    RoomsTableCompanion Function({
      Value<String> id,
      Value<String> job,
      Value<String> level,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RoomsTableTableReferences
    extends BaseReferences<_$AppDatabase, $RoomsTableTable, Rooms> {
  $$RoomsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChatsTableTable, List<Chats>>
  _chatsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chatsTable,
    aliasName: $_aliasNameGenerator(db.roomsTable.id, db.chatsTable.idRoom),
  );

  $$ChatsTableTableProcessedTableManager get chatsTableRefs {
    final manager = $$ChatsTableTableTableManager(
      $_db,
      $_db.chatsTable,
    ).filter((f) => f.idRoom.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoomsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get job => $composableBuilder(
    column: $table.job,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chatsTableRefs(
    Expression<bool> Function($$ChatsTableTableFilterComposer f) f,
  ) {
    final $$ChatsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.idRoom,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableTableFilterComposer(
            $db: $db,
            $table: $db.chatsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoomsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get job => $composableBuilder(
    column: $table.job,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoomsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoomsTableTable> {
  $$RoomsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get job =>
      $composableBuilder(column: $table.job, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> chatsTableRefs<T extends Object>(
    Expression<T> Function($$ChatsTableTableAnnotationComposer a) f,
  ) {
    final $$ChatsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatsTable,
      getReferencedColumn: (t) => t.idRoom,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.chatsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoomsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoomsTableTable,
          Rooms,
          $$RoomsTableTableFilterComposer,
          $$RoomsTableTableOrderingComposer,
          $$RoomsTableTableAnnotationComposer,
          $$RoomsTableTableCreateCompanionBuilder,
          $$RoomsTableTableUpdateCompanionBuilder,
          (Rooms, $$RoomsTableTableReferences),
          Rooms,
          PrefetchHooks Function({bool chatsTableRefs})
        > {
  $$RoomsTableTableTableManager(_$AppDatabase db, $RoomsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RoomsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RoomsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RoomsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> job = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomsTableCompanion(
                id: id,
                job: job,
                level: level,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String job,
                required String level,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoomsTableCompanion.insert(
                id: id,
                job: job,
                level: level,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RoomsTableTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({chatsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (chatsTableRefs) db.chatsTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatsTableRefs)
                    await $_getPrefetchedData<Rooms, $RoomsTableTable, Chats>(
                      currentTable: table,
                      referencedTable: $$RoomsTableTableReferences
                          ._chatsTableRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$RoomsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).chatsTableRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.idRoom == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoomsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoomsTableTable,
      Rooms,
      $$RoomsTableTableFilterComposer,
      $$RoomsTableTableOrderingComposer,
      $$RoomsTableTableAnnotationComposer,
      $$RoomsTableTableCreateCompanionBuilder,
      $$RoomsTableTableUpdateCompanionBuilder,
      (Rooms, $$RoomsTableTableReferences),
      Rooms,
      PrefetchHooks Function({bool chatsTableRefs})
    >;
typedef $$ChatsTableTableCreateCompanionBuilder =
    ChatsTableCompanion Function({
      Value<int> id,
      required String idRoom,
      required String message,
      required String rule,
      Value<DateTime> createdAt,
    });
typedef $$ChatsTableTableUpdateCompanionBuilder =
    ChatsTableCompanion Function({
      Value<int> id,
      Value<String> idRoom,
      Value<String> message,
      Value<String> rule,
      Value<DateTime> createdAt,
    });

final class $$ChatsTableTableReferences
    extends BaseReferences<_$AppDatabase, $ChatsTableTable, Chats> {
  $$ChatsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoomsTableTable _idRoomTable(_$AppDatabase db) =>
      db.roomsTable.createAlias(
        $_aliasNameGenerator(db.chatsTable.idRoom, db.roomsTable.id),
      );

  $$RoomsTableTableProcessedTableManager get idRoom {
    final $_column = $_itemColumn<String>('id_room')!;

    final manager = $$RoomsTableTableTableManager(
      $_db,
      $_db.roomsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idRoomTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableFilterComposer({
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

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rule => $composableBuilder(
    column: $table.rule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RoomsTableTableFilterComposer get idRoom {
    final $$RoomsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRoom,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableFilterComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableOrderingComposer({
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

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rule => $composableBuilder(
    column: $table.rule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoomsTableTableOrderingComposer get idRoom {
    final $$RoomsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRoom,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableOrderingComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatsTableTable> {
  $$ChatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get rule =>
      $composableBuilder(column: $table.rule, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RoomsTableTableAnnotationComposer get idRoom {
    final $$RoomsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idRoom,
      referencedTable: $db.roomsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.roomsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatsTableTable,
          Chats,
          $$ChatsTableTableFilterComposer,
          $$ChatsTableTableOrderingComposer,
          $$ChatsTableTableAnnotationComposer,
          $$ChatsTableTableCreateCompanionBuilder,
          $$ChatsTableTableUpdateCompanionBuilder,
          (Chats, $$ChatsTableTableReferences),
          Chats,
          PrefetchHooks Function({bool idRoom})
        > {
  $$ChatsTableTableTableManager(_$AppDatabase db, $ChatsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ChatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ChatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ChatsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> idRoom = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String> rule = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ChatsTableCompanion(
                id: id,
                idRoom: idRoom,
                message: message,
                rule: rule,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String idRoom,
                required String message,
                required String rule,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ChatsTableCompanion.insert(
                id: id,
                idRoom: idRoom,
                message: message,
                rule: rule,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$ChatsTableTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({idRoom = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (idRoom) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.idRoom,
                            referencedTable: $$ChatsTableTableReferences
                                ._idRoomTable(db),
                            referencedColumn:
                                $$ChatsTableTableReferences._idRoomTable(db).id,
                          )
                          as T;
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

typedef $$ChatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatsTableTable,
      Chats,
      $$ChatsTableTableFilterComposer,
      $$ChatsTableTableOrderingComposer,
      $$ChatsTableTableAnnotationComposer,
      $$ChatsTableTableCreateCompanionBuilder,
      $$ChatsTableTableUpdateCompanionBuilder,
      (Chats, $$ChatsTableTableReferences),
      Chats,
      PrefetchHooks Function({bool idRoom})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RoomsTableTableTableManager get roomsTable =>
      $$RoomsTableTableTableManager(_db, _db.roomsTable);
  $$ChatsTableTableTableManager get chatsTable =>
      $$ChatsTableTableTableManager(_db, _db.chatsTable);
}
