import 'package:drift/drift.dart';
import 'package:interview_app/local/app_database.dart';
import 'package:interview_app/local/tables/files.dart';

@DataClassName('Rooms')
class RoomsTable extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get job => text().withLength(min: 1)();
  TextColumn get level => text().withLength(min: 1)();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();
  TextColumn get idFile => text().references(FilesTable, #id).nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  @override
  Set<Column> get primaryKey => {id};
}

class RoomsRepository {
  final AppDatabase database;

  RoomsRepository(this.database);

  Future<List<Rooms>> getRoomsPaged({int limit = 10, int page = 1}) {
    final offset = (page - 1) * limit;
    return (database.select(database.roomsTable)
          ..orderBy([(c) => OrderingTerm.desc(c.createdAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<List<Rooms>> getAllRooms() {
    return (database.select(database.roomsTable)
      ..orderBy([(c) => OrderingTerm.desc(c.createdAt)])).get();
  }

  Future<Rooms?> getRoomById(String id) {
    return (database.select(database.roomsTable)
      ..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertRoom(RoomsTableCompanion room) async {
    await database.into(database.roomsTable).insert(room);
  }

  Future<void> updateRoom(RoomsTableCompanion room) async {
    await database.update(database.roomsTable).replace(room);
  }

  Future<void> deleteRoom(String id) async {
    await (database.delete(database.chatsTable)
      ..where((t) => t.idRoom.equals(id))).go();
    await (database.delete(database.roomsTable)
      ..where((t) => t.id.equals(id))).go();
  }

  Future<void> updateRoomIsActive(String id, bool isActive) async {
    await (database.update(database.roomsTable)..where(
      (t) => t.id.equals(id),
    )).write(RoomsTableCompanion(isActive: Value(isActive)));
  }
}
