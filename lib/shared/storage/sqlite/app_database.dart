import 'dart:async';
import 'package:floor/floor.dart';
import 'package:furnihome_ar/shared/storage/sqlite/dao/category_dao.dart';
import 'package:furnihome_ar/shared/storage/sqlite/dao/room_dao.dart';
import 'package:furnihome_ar/shared/storage/sqlite/db_constants.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/category_entity.dart';
import 'package:furnihome_ar/shared/storage/sqlite/entity/room_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [
  RoomEntity,
  CategoryEntity,
])
abstract class AppDatabase extends FloorDatabase {
  static AppDatabase? _database;

  static Future<AppDatabase> getInstance() async {
    if (_database == null) {
      Future<AppDatabase> temp = $FloorAppDatabase
          .databaseBuilder(DatabaseConstants.databaseName)
          .build();
      _database = await temp;
    }
    return _database!;
  }
  
  Future<void> clearAllTables() async {
    final db = database;
    final tableNames = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');

    for (var table in tableNames) {
      final tableName = table['name'];
      /* if (tableName != 'sqlite_sequence' && tableName != 'android_metadata') {
        await db.execute('DELETE FROM $tableName');
      }*/
      if (tableName != 'android_metadata') {
        await db.execute('DELETE FROM $tableName');
      }
    }
  }

  RoomDao get roomDao;
  CategoryDao get categoryDao;
}
