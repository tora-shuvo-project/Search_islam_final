import 'package:flutter/foundation.dart';
import 'package:search_islam/data/model/sura_model.dart';
import 'package:search_islam/helper/database_helper.dart';

class QuraanShareefProvider with ChangeNotifier {
  DatabaseHelper _getDatabaseHelper;

  DatabaseHelper get getDatabaseHelper => _getDatabaseHelper;

  accessDatabase(DatabaseHelper db) {
    _getDatabaseHelper = db;
    initializeSuraModels();
    notifyListeners();
  }

  List<SuraModel> _suraModels = [];

  List<SuraModel> get suraModels => _suraModels;

  Future<void> initializeSuraModels() async {
    _getDatabaseHelper.getAllSuraFromSuraNameTable().then((rows) {
      rows.forEach((row) {
        _suraModels.add(SuraModel.formMap(row));
      });
    });
    notifyListeners();
  }
}
