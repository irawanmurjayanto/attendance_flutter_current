import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
 

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE absen(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nik TEXT,
        desc TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'paradise.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item 
  static Future<int> createItem(String? title, String? descrption) async {
    final db = await DatabaseHelper.db();

    final data = {'nik': title, 'desc': descrption};
    final id = await db.insert('absen', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items 
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('absen', orderBy: "id");
  }

  // Get a single item by id
  //We dont use this method, it is for you if you want it.
    static Future<List<Map<String, dynamic>>> getItem(String nik) async {
    final db = await DatabaseHelper.db();
    return db.query('absen', where: "nik = ?", whereArgs: [nik], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String nik, String? desc) async {
    final db = await DatabaseHelper.db();

    final data = {
      'nik': nik,
      'desc': desc,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('absen', data, where: "nik = ?", whereArgs: [nik]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(String nik) async {
    final db = await DatabaseHelper.db();
    try {
     // await db.delete("absen", where: "nik = ?", whereArgs: [nik]);
      await db.delete("absen");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }


    static Future<void> deleteItemAll(String nik) async {
    final db = await DatabaseHelper.db();
    try {
      await db.rawQuery('delete from absen');
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}