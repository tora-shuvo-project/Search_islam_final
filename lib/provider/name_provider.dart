import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/data/model/name_model.dart';
import 'package:search_islam/data/repository/name_repo.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';

class NameProvider with ChangeNotifier {
  final NameRepo nameRepo;

  NameProvider({this.nameRepo});

  Future<void> addNameInFireBaseDatabase() async {
    // nameRepo.getAllNameList.forEach((name) {
    //   Timer.periodic(Duration(seconds: 2), (timer) async {
    //     await FirestoreDatabaseHelper.addComment(name);
    //   });
    //
    //   //print(name.toMap());
    // });
    await FirestoreDatabaseHelper.addNameToFirebase(NameModel('1', 'আবরার', 'ন্যায়বান', 1));
    notifyListeners();
  }

  List<NameModel> _getAllNameList = [];
  List<NameModel> _getAllNameListSave = [];

  List<NameModel> get getAllNameList => _getAllNameList;

  initializeData(int categoryID) async {
    _getAllNameList = [];
    FirestoreDatabaseHelper.nameLists(categoryID).then((value) {
      for (int i = value.length - 1; i >= 0; i--) {
        _getAllNameList.add(value[i]);
        _getAllNameListSave.add(value[i]);
      }
      notifyListeners();
    });
  }

  // For Search
  bool _notEmptyText = false;

  bool get notEmptyText => _notEmptyText;
  TextEditingController controller = TextEditingController();

  searchName(String query) {
    if (query.isEmpty) {
      _getAllNameList.clear();
      _getAllNameList = _getAllNameListSave;
      _notEmptyText = false;
    } else {
      _notEmptyText = true;
      _getAllNameList = [];
      _getAllNameListSave.forEach((name) async {
        if (name.title.toLowerCase().contains(query.toLowerCase())) {
          _getAllNameList.add(name);
        }
      });
    }
    notifyListeners();
  }

  clearSearchList() {
    _notEmptyText = false;
    _getAllNameList.clear();
    _getAllNameList = _getAllNameListSave;
    controller.clear();
    notifyListeners();
  }

}
