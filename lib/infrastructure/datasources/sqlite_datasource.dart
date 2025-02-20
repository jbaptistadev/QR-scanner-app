import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:qr_scanner_app/domain/datasource/local_storage_datasource.dart';
import 'package:qr_scanner_app/domain/entities/user.dart';
import 'package:qr_scanner_app/infrastructure/models/user_sqlite.dart';

class SQLiteDataSource extends LocalStorageDataSource {
  late Future<Database> db;

  SQLiteDataSource() {
    db = openDb();
  }

  Future<Database> openDb() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'qr_scanner_app.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      throw Exception();
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE User (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT UNIQUE,
          fullName TEXT,
          password TEXT
        )
    ''');
    await db.execute('''
      CREATE TABLE Scan (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId INTEGER,
          create_date INTEGER,
          description TEXT,
          FOREIGN KEY (userId) REFERENCES User(id)
        )
    ''');
  }

  @override
  Future<User> createUser(String fullName, String username) async {
    final sqLite = await db;

    final newUser = UserModel(username: username, fullName: fullName);

    final id = await sqLite.insert('User', newUser.toMap());

    return User(id: id, username: username, fullName: fullName);
  }

  @override
  Future<User?> findUser() async {
    final sqLite = await db;

    final List<Map<String, dynamic>> results = await sqLite.query(
      'User',
      limit: 1,
    );

    if (results.isNotEmpty) {
      return User.fromMap(results.first);
    } else {
      return null;
    }
  }

  @override
  Future<void> deleteUsers() async {
    final sqLite = await db;
    await sqLite.delete('User');
  }

  Future<void> closeDb() async {
    final sqLite = await db;
    await sqLite.close();
  }
}
