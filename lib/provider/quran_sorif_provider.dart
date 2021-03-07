import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  List<SuraModel> _suraList = [];
  List<SuraModel> _allSuraList = [];

  List<SuraModel> get suraModels => _suraList;

  Future<void> initializeSuraModels() async {
    _getDatabaseHelper.getAllSuraFromSuraNameTable().then((rows) {
      rows.forEach((row) {
        _suraList.add(SuraModel.formMap(row));
        _allSuraList.add(SuraModel.formMap(row));
      });
    });
    notifyListeners();
  }

  bool _notEmptyText = false;

  bool get notEmptyText => _notEmptyText;
  TextEditingController controller = TextEditingController();

  searchProduct(String query) {
    if (query.isEmpty) {
      _suraList.clear();
      _suraList = _allSuraList;
      _notEmptyText = false;
    } else {
      _notEmptyText = true;
      _suraList = [];
      _allSuraList.forEach((suraModel) async {
        if (suraModel.keyName.toLowerCase().contains(query.toLowerCase())) {
          _suraList.add(suraModel);
        }
      });
    }
    notifyListeners();
  }

  clearSearchList() {
    _notEmptyText = false;
    _suraList.clear();
    _suraList = _allSuraList;
    controller.clear();
    notifyListeners();
  }
}
