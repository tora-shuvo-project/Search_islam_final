import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/data/model/sura_model.dart';
import 'package:search_islam/data/repository/quran_repo.dart';
import 'package:search_islam/helper/database_helper.dart';
import 'package:search_islam/provider/ayat_model.dart';

class QuraanShareefProvider with ChangeNotifier {
  final QuranRepo quranRepo;

  QuraanShareefProvider({@required this.quranRepo});

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
  bool _isPlayAyatAudio = false;

  bool get isPlayAyatAudio => _isPlayAyatAudio;
  int _playAudioIndex = 0;

  int get playAudioIndex => _playAudioIndex;

  playAyatAudio({@required BuildContext context, @required String audioUrl, int index}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          ayatPlayer.play(audioUrl);
          ayatPlayer.onPlayerStateChanged.listen((s) {
            if (s == AudioPlayerState.PLAYING) {
              _isPlayAyatAudio = true;
              _playAudioIndex = index - 1;
              notifyListeners();
            } else if (s == AudioPlayerState.COMPLETED) {
              _isPlayAyatAudio = false;
              notifyListeners();
            }
          });
        }

        /// on catching Exception return null
        catch (err) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text('Audio Path Error'),
          ));
          return null;
        }
      }
    } on SocketException catch (_) {
      print('not connected');
      // ignore: deprecated_member_use
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
  }

  // for play sura sudio

  AudioPlayer suraPlayer = AudioPlayer();
  bool isPlaying = false;
  double showPercentage = 0.0;
  String downloadMessahge = '0';
  bool isDownload = true;
  AudioModel audioModel = AudioModel();
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();
  bool cancelTokenStatus = false;

  initializeAudioModel(int suraNo, String qareName) async {
    _getDatabaseHelper.getAudioBySuraAndQareName(suraNo, qareName).then((rows) async {
      audioModel = rows;
    });
    notifyListeners();
  }

  cancelDownload() {
    cancelToken.cancel('cancelled');
    notifyListeners();
  }

  playAudioANdDownload({int suraNo, String qareName, String url, BuildContext context}) async {
    final filename = 'sura $suraNo $qareName.mp3';
    String dir = (await getExternalStorageDirectory()).path;
    if (await File('$dir/$filename').exists()) {
      print('$dir/$filename');

      if (isPlaying) {
        suraPlayer.play('$dir/$filename');
        isPlaying = false;
      } else {
        suraPlayer.pause();
        isPlaying = true;
      }

      ayatPlayer.onPlayerStateChanged.listen((s) {
        if (s == AudioPlayerState.COMPLETED) {
          isPlaying = true;
          notifyListeners();
        }
      });
    } else {
      showPercentage = 0.0;
      cancelToken = CancelToken();
      cancelTokenStatus = false;
      await dio.download('$url', '$dir/$filename', onReceiveProgress: (actualBytes, totalBytes) {
        var percentage = actualBytes / totalBytes * 100;
        if (percentage <= 100) {
          showPercentage = percentage / 100;
          isDownload = false;
          downloadMessahge = '${percentage.floor()}';
          print(downloadMessahge);
          notifyListeners();
          if (percentage == 100) {
            isDownload = true;
            if (isPlaying) {
              suraPlayer.play('$dir/$filename');
              isPlaying = false;
            } else {
              suraPlayer.pause();
              isPlaying = true;
            }
          }
        }
      }, cancelToken: cancelToken).catchError((error) {

        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            elevation: 2,
            duration: Duration(seconds: 5),
            content: Text(error.message=='cancelled'?'Download Canceled':
            'Please check your internet connection first time it download for you from server \'Thanks',
              style: TextStyle(color: Colors.white),
            )));
      });
    }
    notifyListeners();
  }

  stopSuraAudioPlayer() async {
    await suraPlayer.stop();
    isPlaying = true;
    notifyListeners();
  }

  // sharefernce
  List<QareModel> _qares = [];
  QareModel qareModel = QareModel();

  List<QareModel> get qares => _qares;

  initializeAllQare() {
    if (_qares.length == 0) {
      _qares.clear();
      _qares = quranRepo.qareodels;
      qareModel = _qares.first;
      notifyListeners();
    }
  }

  String qareName = '';

  changeQareName(QareModel qareM) {
    qareModel = qareM;
    qareName = qareM.banglaName;
    saveQareName(qareM.englishName);
    notifyListeners();
  }

// Save Qare Name

  saveQareName(String name) async {
    return quranRepo.saveQareNameInPreference(name);
  }

  String getQareName() {
    return quranRepo.getQareNameFromPreference();
  }
}
