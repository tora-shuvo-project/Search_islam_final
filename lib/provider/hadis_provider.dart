import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/data/model/hadis_chapter_model.dart';

class HadisProvider with ChangeNotifier {
  List<HadisChapterModel> _hadisChapterList = [];

  List<HadisChapterModel> get hadisChapterList => _hadisChapterList;

  loadJsonData(BuildContext context) async {
    _hadisChapterList = [];
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/hadis_chapters.json");
    final dmap = json.decode(data);
    dmap.forEach((element) {
      _hadisChapterList.add(HadisChapterModel.fromJson(element));
    });

    print(_hadisChapterList.length.toString());
    notifyListeners();
  }
}
