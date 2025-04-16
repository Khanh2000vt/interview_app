import 'package:drift/drift.dart';
import 'package:interview_app/local/app_database.dart';
import 'package:interview_app/local/tables/rooms.dart';

@DataClassName('Chats')
@TableIndex(name: 'idx_idRoom', columns: {#idRoom})
class ChatsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get idRoom => text().references(RoomsTable, #id)();
  TextColumn get message => text().withLength(min: 1)();
  TextColumn get rule => text().withLength(min: 1)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class ChatsRepository {
  final AppDatabase database;

  ChatsRepository(this.database);

  Future<List<Chats>> getChatsByRoomPaged(
    String idRoom, {
    int limit = 10,
    int page = 1,
  }) {
    final offset = (page - 1) * limit;
    return (database.select(database.chatsTable)
          ..where((c) => c.idRoom.equals(idRoom))
          ..orderBy([(c) => OrderingTerm.desc(c.createdAt)])
          ..limit(limit, offset: offset))
        .get();
  }

  Future<List<Chats>> getAllChatsByRoom(String idRoom) {
    return (database.select(database.chatsTable)
          ..where((c) => c.idRoom.equals(idRoom))
          ..orderBy([(c) => OrderingTerm.desc(c.createdAt)]))
        .get();
  }

  Future<void> insertChat(ChatsTableCompanion chat) async {
    await database.into(database.chatsTable).insert(chat);
  }

  Future<void> insertAllChat(List<ChatsTableCompanion> chats) async {
    await database.batch((batch) {
      batch.insertAll(database.chatsTable, chats);
    });
  }
}
