import 'package:flutter/foundation.dart';
import 'package:search_islam/data/model/ojifa_model.dart';
import 'package:search_islam/helper/database_helper.dart';

class OjifaProvider with ChangeNotifier {
  DatabaseHelper _getDatabaseHelper;

  DatabaseHelper get getDatabaseHelper => _getDatabaseHelper;

  accessDatabase(DatabaseHelper db) {
    _getDatabaseHelper = db;
    notifyListeners();
  }

  // get all Ojifa List
  List<OjifaModel> _getAllOjifaModel = [];

  List<OjifaModel> get getAllOjifaModel => _getAllOjifaModel;

  Future<void> initializeAllOjifa(int topicNo) async {
    _getAllOjifaModel = [];

    _getDatabaseHelper.getAllSubOjifaFromOjifaTable(topicNo).then((rows) {
      rows.forEach((row) {
        _getAllOjifaModel.add(OjifaModel.fromMap(row));
      });
      notifyListeners();
    });
  }

  // get Ojifa

  OjifaModel _ojifaModel;

  OjifaModel get ojifaModel => _ojifaModel;

  Future<void> initializeOjifaModel(int topicNo, int subTopicNo) async {
    _ojifaModel = OjifaModel();
    _ojifaModel = await _getDatabaseHelper.getAllOjifaFromOjifaTable(topicNo, subTopicNo);
    print(_ojifaModel.toString());
    notifyListeners();
  }
}
