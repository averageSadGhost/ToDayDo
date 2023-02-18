import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "todoTasks";

  static Future<void> initDb() async {
    if (_db != null) {
      debugPrint("Found DB");
    } else {
      try {
        // ignore: prefer_interpolation_to_compose_strings
        String path = await getDatabasesPath() + "todoTasks";
        _db = await openDatabase(path, version: _version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING,note TEXT,date STRING,startTime STRING,enddTime STRING,remind INTEGER,repeat STRING,color INTEGER,isCompleted INTEGER)");
          debugPrint("Created DB");
        });
      } catch (error) {
        debugPrint("Error while creating DB: ${error.toString()}");
      }
    }
  }

  static Future<int> insert(Task? task) async {
    debugPrint("DB insert called");
    return await _db!.insert(_tableName, task!.toJson());
  }

  static Future<int> delete(Task task) async {
    debugPrint("DB delete called");
    return await _db!.delete(_tableName, where: "id = ?", whereArgs: [task.id]);
  }

  static Future<List<Map<String, Object?>>> query() async {
    debugPrint("DB query called");
    return await _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    debugPrint("DB update called");
    return await _db!.rawUpdate(
        "UPDATE toDoTasks SET isCompleted = ? WHERE id = ?", [1, id]);
  }
}
