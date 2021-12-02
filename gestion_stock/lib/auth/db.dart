import 'dart:developer';

import 'package:gestion_stock/models/admin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  MyDatabase._();
  static final MyDatabase db = MyDatabase._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await initDB();
        return _database;
      }
    
    initDB() async {
    String path = join(getDatabasesPath().toString(), "database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE admin ("
          "username EMAIL PRIMARY KEY,"
          "password TEXT"
          ")");
          


      await db.execute("CREATE TABLE member("
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "first_name TEXT NOT NULL,"
      "last_name TEXT NOT NULL,"
      "num1 INTEGER NOT NULL,"
      "num2 INTEGER)"); 
        });
    
  }
  newAdmin(Admin newAdmin) async {
    final db = await database;
    var res = await db?.insert("Admin", newAdmin.toMap());
    return res;
  }

  Future<Admin> getAdmin(String username) async {
    final db = await database;
    var res = await  db?.query("Admin",where: "username = ?", whereArgs: [username]);
    print("--el get -"+res.toString());
    if (res!.isNotEmpty) {
      return Admin.fromMap(res.first);
    }
    else
    {
      return Admin("","");
    }
    
  }

}
