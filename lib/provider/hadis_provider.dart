import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/data/model/hadis_chapter_model.dart';
import 'package:search_islam/data/model/hadis_details_model.dart';

class HadisProvider with ChangeNotifier {
  List<HadisChapterModel> _hadisChapterList = [];

  List<HadisChapterModel> get hadisChapterList => _hadisChapterList;

  loadHadisChapterData(BuildContext context) async {
    _hadisChapterList = [];
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/hadis_chapters.json");
    final dmap = json.decode(data);
    dmap.forEach((element) {
      _hadisChapterList.add(HadisChapterModel.fromJson(element));
    });

    print(_hadisChapterList.length.toString());
    notifyListeners();
  }

  // hadis full
  List<HadisDetailsModel> _hadisDetailsModel=[];
  List<HadisDetailsModel> get hadisDetailsModel=>_hadisDetailsModel;

  loadHadisDetailsData(BuildContext context,int startIndex,int endIndex) async {
    _hadisDetailsModel = [];
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/bukhari_sharif_bangla.json");
    final dmap = json.decode(data);
    for(startIndex;startIndex<=endIndex;startIndex++){
      _hadisDetailsModel.add(HadisDetailsModel.fromJson(dmap.elementAt(startIndex-1)));
    }

    print(_hadisDetailsModel.length.toString());
    notifyListeners();
  }
}
