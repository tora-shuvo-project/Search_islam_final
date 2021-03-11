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
  final QuranRepo quraanRepo;

  QuraanShareefProvider({@required this.quraanRepo});

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
  bool _isShowOther = true;

  bool isShowBanglaMeaning() {
    return quraanRepo.getBanglaMeaningFromPreference();
  }

  bool isShowBanglaTranslate() {
    return quraanRepo.getBanglaTranslatorFromPreference();
  }

  bool isShowArabic() {
    return quraanRepo.getArabicFromPreference();
  }

  bool get isShowOther => _isShowOther;

  void checkTemp() async {
    if (!quraanRepo.getBanglaMeaningFromPreference() &&
        !quraanRepo.getBanglaTranslatorFromPreference() &&
        !quraanRepo.getArabicFromPreference() &&
        !_isShowOther) quraanRepo.saveArabicInPreference(true);
  }

  updateBanglaMeaningStatus(bool status) {
    quraanRepo.saveBanglaMeaningInPreference(status);

    checkTemp();

    notifyListeners();
  }

  updateBanglaTranslateStatus(bool status) {
    quraanRepo.saveBanglaTranslatorInPreference(status);
    checkTemp();
    notifyListeners();
  }

  updateArabicStatus(bool status) {
    quraanRepo.saveArabicInPreference(status);
    checkTemp();
    notifyListeners();
  }

  updateOtherStatus(bool status) {
    _isShowOther = status;
    checkTemp();
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
          ayatPlayer = AudioPlayer();
          suraPlayer.stop();
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
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(new SnackBar(
          backgroundColor: Colors.red,
          elevation: 2,
          duration: Duration(seconds: 5),
          content: Text(
            'Please check your internet connection \'Thanks',
            style: TextStyle(color: Colors.white),
          )));
    }
  }

  // for play sura sudio

  AudioPlayer suraPlayer = AudioPlayer();
  bool isPlaying = false;
  double showPercentage = 0.0;
  String downloadMessahge = '0';
  bool isDownload = false;
  AudioModel audioModel = AudioModel();
  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();
  bool showDownloadWidget = false;
  int statusCode = 0;

  dismissAudio() async {
    await suraPlayer.stop();
    await ayatPlayer.stop();
    notifyListeners();
  }

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

  playAudioANdDownload({int suraNo, String qareName, String url, BuildContext context, Function percentFunction}) async {
    final filename = 'sura $suraNo $qareName.mp3';
    String dir = (await getExternalStorageDirectory()).path;
    statusCode = 0;
    if (await File('$dir/$filename').exists()) {
      print('$dir/$filename');
      showDownloadWidget = false;
      isPlaying = !isPlaying;

      if (isPlaying) {
        suraPlayer.play('$dir/$filename');
      } else {
        suraPlayer.pause();
      }

      suraPlayer.onPlayerStateChanged.listen((s) {
        if (s == AudioPlayerState.COMPLETED) {
          isPlaying = false;
          notifyListeners();
        }
      });
    } else {
      showPercentage = 0.0;
      cancelToken = CancelToken();
      showDownloadWidget = true;
      isDownload = true;
      statusCode = 0;
      await dio.download('$url', '$dir/$filename', onReceiveProgress: (actualBytes, totalBytes) {
        var percentage = actualBytes / totalBytes * 100;
        if (percentage <= 100) {
          showPercentage = percentage / 100;
          print(isDownload);
          if (isDownload) {
            statusCode = 1;
            print(statusCode);
            percentFunction(statusCode);
          }
          isDownload = false;
          downloadMessahge = '${percentage.floor()}';
          print(showPercentage);
          notifyListeners();
          if (percentage == 100) {
            isDownload = true;
            if (isPlaying) {
              suraPlayer.play('$dir/$filename');
            } else {
              suraPlayer.pause();
            }
          }
        }
      }, cancelToken: cancelToken).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            backgroundColor: Colors.red,
            elevation: 2,
            duration: Duration(seconds: 5),
            content: Text(
              error.message == 'cancelled'
                  ? 'Download Canceled'
                  : 'Please check your internet connection first time it download for you from server \'Thanks',
              style: TextStyle(color: Colors.white),
            )));
      });
    }
    notifyListeners();
  }

  stopSuraAudioPlayer() async {
    await suraPlayer.stop();
    await ayatPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }

  // sharefernce
  List<QareModel> _qares = [];
  QareModel qareModel = QareModel();

  List<QareModel> get qares => _qares;

  initializeAllQare() {
    if (_qares.length == 0) {
      _qares.clear();
      _qares = quraanRepo.qareodels;
      qareModel = _qares.first;
      notifyListeners();
    }
  }

  String qareName = '';

  changeQareName(QareModel qareM) {
    qareModel = qareM;
    qareName = qareM.banglaName;
    saveQareName(qareM.englishName);
    showPercentage = 0.0;
    stopSuraAudioPlayer();
    notifyListeners();
  }

// Save Qare Name

  saveQareName(String name) async {
    return quraanRepo.saveQareNameInPreference(name);
  }

  String getQareName() {
    return quraanRepo.getQareNameFromPreference();
  }

  // for general Settings

  // for Font Size Range Slider
  double fontSize = 18;

  changeFontSize(double value) {
    fontSize = value;
    notifyListeners();
  }
}
