import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/data/model/ojifa_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class DatabaseHelper {
  static final databaseName = 'ISLAM.db';
  static final databaseVersion = 1;

  //Table Name
  static final suraTable = 'SuraNameTbl';
  static final ayatTable = 'AyatTbl';
  static final audioTable = 'AudioTbl';
  static final paraTable = 'ParaNameTbl';
  static final quranWordTable = 'QuranWorkMeaningTbl';
  static final ojifaTable = 'OjifaTbl';
  static final dunaNameTable = 'DuaNameTbl';
  static final duyaDetailsTable = 'DuaDetailsTbl';
  static final hadisTable = 'HadisTbl';
  static final niyomTable = 'NiyomTbl';

  //Column Name
  static final columnSuraNo = 'SURANO';
  static final columnQarename = 'QARINAME';
  static final columnEnglishName = 'ENGLISHSURANAME';
  static final columnBanglaName = 'BANGLATRANSLATOR';
  static final columnArabi = 'ARABISURANAME';
  static final columnobotirno = 'OBOTIRNO';
  static final columnparaNo = 'PARA';
  static final columndate = 'DATEPRAYER';
  static final columntopicNo = 'TOPICNO';
  static final columnsubtopicNo = 'SUBTOPICNO';
  static final columndoyaID = 'ID';
  static final columnCategory = 'CATEGORY';
  static final columnduyaName = 'NAME';
  static final columnGlobalId = 'GLOBAL_ID';

  DatabaseHelper._privateConstrator();

  static final DatabaseHelper instance = DatabaseHelper._privateConstrator();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);

    var exists = await databaseExists(path);
    if (!exists) {
      print('Copy Database Start');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets/database/", databaseName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      //write
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print('Opening existing database');
    }

    return await openDatabase(path, version: databaseVersion);
  }

  ///CRUD
  ///==========================================================

  //Select All
  Future<List> getAllSuraFromSuraNameTable() async {
    Database db = await instance.database;
    var result = await db.query(suraTable);
    return result.toList();
  }

  Future<List> getAllHadisFromHadisTable() async {
    Database db = await instance.database;
    var result = await db.query(hadisTable);
    return result.toList();
  }

   Future<List> getAllParaNameFromTable() async {
    Database db = await instance.database;
    var result = await db.query(paraTable);
    return result.toList();
  }

  Future<List> getAllQuranWordFromTable() async {
    Database db = await instance.database;
    var result = await db.query(quranWordTable);
    return result.toList();
  }

  Future<List> getAllAyatFromParaTable(int paraNo) async {
    Database db = await instance.database;
//    var result=await db.rawQuery('SELECT * FROM $ayatTable WHERE SURANO=$suraNo;');
    var result = await db.query(ayatTable, where: '$columnparaNo= ?', whereArgs: [paraNo]);
    return result.toList();
  }

  Future<List> getAllSubOjifaFromOjifaTable(int topicno) async {
    Database db = await instance.database;
    var result = await db.query(ojifaTable, where: '$columntopicNo = ? ', whereArgs: [topicno]);
    return result.toList();
  }

  Future<List> getDuyaNameFromTable() async {
    Database db = await instance.database;
    var result = await db.query(dunaNameTable,orderBy: 'GLOBAL_ID');
    return result.toList();
  }

  Future<List> getDuyaCategoryNameFromTable(int category) async {
    Database db = await instance.database;
    var result = await db.query(dunaNameTable, where: '$columnCategory = ? ', whereArgs: [category],orderBy: 'GLOBAL_ID');
    return result.toList();
  }

  Future<List> getDuyaDetailsFromTable(String id) async {
    Database db = await instance.database;
    var result = await db.query(duyaDetailsTable, where: '$columndoyaID = ? ', whereArgs: [id]);
    return result.toList();
  }

  Future<List> getNiyomCategoryFromNiyomTable(int category) async {
    Database db = await instance.database;
    var result = await db.query(niyomTable, where: '$columnCategory = ? ', whereArgs: [category]);
    return result.toList();
  }

  Future<OjifaModel> getAllOjifaFromOjifaTable(int topicno, int subtopicno) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> result =
        await db.query(ojifaTable, where: '$columntopicNo = ? AND $columnsubtopicNo = ? ', whereArgs: [topicno, subtopicno]);
    if (result.length > 0) {
      return OjifaModel.fromMap(result.first);
    }
    return null;
  }

  Future<List> searchSuraFromSuraNameTable(String name) async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        " SELECT * FROM $suraTable WHERE  $columnEnglishName LIKE '%$name%' OR $columnBanglaName LIKE '%$name%' OR $columnArabi LIKE '%$name%' OR $columnSuraNo LIKE '%$name%' OR $columnobotirno LIKE '%$name%' ");
    return result.toList();
  }

   Future<List> searchDoyaFromDoyaNameTable(String name) async {
    Database db = await instance.database;
    var result = await db.rawQuery(" SELECT * FROM $dunaNameTable WHERE  $columnGlobalId LIKE '%$name%' OR $columnduyaName LIKE '%$name%'");
    return result.toList();
  }

  Future<List> getAllAyatFromAyatTable(int suraNo) async {
    Database db = await instance.database;
//    var result=await db.rawQuery('SELECT * FROM $ayatTable WHERE SURANO=$suraNo;');
    var result = await db.query(ayatTable, where: '$columnSuraNo= ?', whereArgs: [suraNo]);
    return result.toList();
  }

  Future<AudioModel> getAudioBySuraAndQareName(int surano, String qarename) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> qareNames =
        await db.query(audioTable, where: '$columnSuraNo = ? AND $columnQarename = ?', whereArgs: [surano, qarename]);
    if (qareNames.length > 0) {
      return AudioModel.fromMap(qareNames.first);
    }
    return null;
  }
}
