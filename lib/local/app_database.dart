//flutter pub run build_runner build --delete-conflicting-outputs
//dart run build_runner watch
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:interview_app/local/tables/chats.dart';
import 'package:interview_app/local/tables/files.dart';
import 'package:interview_app/local/tables/rooms.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [RoomsTable, ChatsTable, FilesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(
        executor ??
            driftDatabase(
              name: 'app-db',
              native: DriftNativeOptions(
                databaseDirectory: getApplicationSupportDirectory,
              ),
              web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'),
              ),
            ),
      );
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}

// QueryExecutor _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'app.db'));
//     return NativeDatabase(file);
//   });
// }
