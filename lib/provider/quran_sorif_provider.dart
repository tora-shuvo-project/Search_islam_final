import 'package:flutter/foundation.dart';
import 'package:search_islam/data/model/sura_model.dart';
import 'package:search_islam/helper/database_helper.dart';

class QuranSharifProvider with ChangeNotifier{
  DatabaseHelper suranamedbHelpers;

  QuranSharifProvider(){
    suranamedbHelpers = DatabaseHelper.instance;
  }

  List<SuraModel> _suraModels=[];
List<SuraModel> get suraModels=>_suraModels;

  initializeSuraModels(){
    suranamedbHelpers.getAllSuraFromSuraNameTable().then((rows){
      rows.forEach((row) {
        _suraModels.add(SuraModel.formMap(row));
      });
    });
  }
}