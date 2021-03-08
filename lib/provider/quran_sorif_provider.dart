import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/data/model/sura_model.dart';
import 'package:search_islam/helper/database_helper.dart';
import 'package:search_islam/provider/ayat_model.dart';

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

  // For Search
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

  // For Ayat
  List<AyatModel> _getAllSuraAyat = [];

  List<AyatModel> get getAllSuraAyat => _getAllSuraAyat;

  initializeAyatBySuraId(int id) async {
    _getAllSuraAyat.clear();
    _getDatabaseHelper.getAllAyatFromAyatTable(id).then((rows) {
      rows.forEach((row) {
        _getAllSuraAyat.add(AyatModel.formMap(row));
        //print(row.toString());
        print(_getAllSuraAyat.length);
      });
      notifyListeners();
    });
  }

  // for hide section
  bool _isShowBanglaMeaning = true;
  bool _isShowBanglaTranslate = true;
  bool _isShowArabic = true;
  bool _isShowOther = true;
  bool _isExpanded = false;

  bool get isShowBanglaMeaning => _isShowBanglaMeaning;

  bool get isShowBanglaTranslate => _isShowBanglaTranslate;

  bool get isShowArabic => _isShowArabic;

  bool get isShowOther => _isShowOther;

  bool get isExpanded => _isExpanded;

  updateBanglaMeaningStatus(bool status) {
    _isShowBanglaMeaning = status;
    if (!_isShowBanglaMeaning && !_isShowBanglaTranslate && !_isShowArabic && !_isShowOther) _isShowArabic = true;
    notifyListeners();
  }

  updateBanglaTranslateStatus(bool status) {
    _isShowBanglaTranslate = status;
    if (!_isShowBanglaMeaning && !_isShowBanglaTranslate && !_isShowArabic && !_isShowOther) _isShowArabic = true;
    notifyListeners();
  }

  updateArabicStatus(bool status) {
    _isShowArabic = status;
    print(_isShowArabic);
    if (!_isShowBanglaMeaning && !_isShowBanglaTranslate && !_isShowArabic && !_isShowOther) _isShowArabic = true;
    notifyListeners();
  }

  updateOtherStatus(bool status) {
    _isShowOther = status;
    if (!_isShowBanglaMeaning && !_isShowBanglaTranslate && !_isShowArabic && !_isShowOther) _isShowArabic = true;
    notifyListeners();
  }

  updateExpandStatus() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  // for audio section

  AudioPlayer ayatPlayer = AudioPlayer();
  bool _isPlayAyatAudio=false;
  bool get isPlayAyatAudio=>_isPlayAyatAudio;
  int _playAudioIndex=0;
  int get playAudioIndex=>_playAudioIndex;

  playAyatAudio({@required BuildContext context, @required String audioUrl,int index}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {


        try {
          ayatPlayer.play(audioUrl);
          ayatPlayer.onPlayerStateChanged.listen((s) {
            if(s== AudioPlayerState.PLAYING){
              _isPlayAyatAudio=true;
              _playAudioIndex=index-1;
              notifyListeners();
            } else if(s==AudioPlayerState.COMPLETED){
              print('complete');
              _isPlayAyatAudio=false;
              notifyListeners();
            }

          });
        }

        /// on catching Exception return null
        catch (err) {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('Audio Path Error'),
          ));
          return null;
        }


      }
    } on SocketException catch (_) {
      print('not connected');
      Scaffold.of(context).showSnackBar(new SnackBar(
          backgroundColor: Colors.red,
          elevation: 2,
          duration: Duration(seconds: 5),
          content: Text(
            'Please check your internet connection \'Thanks',
            style: TextStyle(
              color: Colors.white,
            ),
          )));
    }
    //print('Finished');
  }
}
