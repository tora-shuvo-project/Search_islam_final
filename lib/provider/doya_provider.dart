import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/data/model/doya_name_models.dart';
import 'package:search_islam/data/repository/doya_repo.dart';
import 'package:search_islam/helper/database_helper.dart';

class DoyaProvider with ChangeNotifier {
  final DoyaRepo doyaRepo;

  DoyaProvider({this.doyaRepo});

  DatabaseHelper _getDatabaseHelper;

  DatabaseHelper get getDatabaseHelper => _getDatabaseHelper;

  accessDatabase(DatabaseHelper db) {
    _getDatabaseHelper = db;
    initializeDoyaNames();
    notifyListeners();
  }

  // for page view builder
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // for animation text
  List<String> allAnimationText = [];

  initializeAnimationText() {
    if (allAnimationText.length == 0) {
      allAnimationText.clear();
      allAnimationText = doyaRepo.allAnimationText;
      notifyListeners();
    }
  }

  // for sura List
  List<DoyaNameModels> _doyaNameList = [];
  List<DoyaNameModels> _allDoyaNameList = [];

  List<DoyaNameModels> get doyaNameList => _doyaNameList;

  Future<void> initializeDoyaNames() async {
    if (_allDoyaNameList.length == 0) {
      _getDatabaseHelper.getDuyaNameFromTable().then((rows) {
        rows.forEach((row) {
          _doyaNameList.add(DoyaNameModels.fromMap(row));
          _allDoyaNameList.add(DoyaNameModels.fromMap(row));
        });
      });
      notifyListeners();
    }
  }

  // For Search
  bool _notEmptyText = false;

  bool get notEmptyText => _notEmptyText;
  TextEditingController controller = TextEditingController();

  searchDoyaByNames(String query) {
    if (query.isEmpty) {
      _doyaNameList.clear();
      _doyaNameList = _allDoyaNameList;
      _notEmptyText = false;
    } else {
      _notEmptyText = true;
      _doyaNameList = [];
      _allDoyaNameList.forEach((doyaNameModel) async {
        if (doyaNameModel.name.toLowerCase().contains(query.toLowerCase())) {
          _doyaNameList.add(doyaNameModel);
        }
      });
    }
    notifyListeners();
  }
  clearSearchList() {
    _notEmptyText = false;
    _doyaNameList.clear();
    _doyaNameList = _allDoyaNameList;

    controller.clear();
    notifyListeners();
  }

}
