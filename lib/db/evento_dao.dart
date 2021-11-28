import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class EventoDao {

  static const _databaseName = 'CheckIn.db';
  static const _databaseVersion = 1;

  static const table = 'evento';
  static const columnId = 'id_evento';
  static const columnNome = 'nome';
  static const columnData = 'data';
/*

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initDatabase();

  EventoDao._privateConstructor();
  static final EventoDao instance = EventoDao._privateConstructor();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }
  // SQL create DB
  Future _onCreate(Database db, int version) async {
    await db.execute('''
         CREATE TABLE evento (
            id_evento INTEGER PRIMARY KEY,
            nome TEXT NOT NULL,
            data TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsDesc() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table ORDER BY id DESC');
  }
*//*
  Future<List<Map<String, dynamic>>> queryAllByState(int state) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table WHERE $columnState = $state');
  }

  Future<List<Map<String, dynamic>>> queryAllByStateDesc(int state) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table WHERE $columnState = $state ORDER BY id_task DESC');
  }*//*

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }*/

}