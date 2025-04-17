import 'package:drift/drift.dart';
import 'package:interview_app/local/app_database.dart';

@DataClassName('Files')
class FilesTable extends Table {
  TextColumn get id => text().withLength(min: 1)();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  BlobColumn get fileContent => blob()();
  @override
  Set<Column> get primaryKey => {id};
}

class FilesRepository {
  final AppDatabase database;

  FilesRepository(this.database);

  Future<void> insertFile(FilesTableCompanion file) async {
    await database.into(database.filesTable).insert(file);
  }

  Future<List<Files>> getAllFiles() {
    return (database.select(database.filesTable)
      ..orderBy([(c) => OrderingTerm.desc(c.fileName)])).get();
  }

  Future<Files?> getFileById(String id) {
    return (database.select(database.filesTable)
      ..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}
