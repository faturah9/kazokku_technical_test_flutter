import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const usersFollowTABLE = 'USERS_FOLLOW';
const postLikeTABLE = 'POST_LIKE';

class DbClient {
  Future<Database> call() async {
    final databasesPath = await getDatabasesPath();

    final path = join(databasesPath, 'kazokku.db');

    return await openDatabase(
      path,
      version: 15,
      onUpgrade: (db, oldVersion, newVersion) {},
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $usersFollowTABLE (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idUser TEXT,
            follow INTEGER
          )''',
        );

        await db.execute(
          '''CREATE TABLE $postLikeTABLE (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idPost TEXT,
            like INTEGER
          )''',
        );
      },
    );
  }
}
