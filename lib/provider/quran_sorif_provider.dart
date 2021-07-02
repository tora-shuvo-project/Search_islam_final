import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/data/model/ayat_model.dart';
import 'package:search_islam/data/model/key_model.dart';
import 'package:search_islam/data/model/para_models.dart';
import 'package:search_islam/data/model/quran_word_models.dart';
import 'package:search_islam/data/model/sura_model.dart';
import 'package:search_islam/data/repository/quran_repo.dart';
import 'package:search_islam/helper/database_helper.dart';

class QuraanShareefProvider with ChangeNotifier {
  final QuranRepo quraanRepo;

  QuraanShareefProvider({@required this.quraanRepo});

  DatabaseHelper _getDatabaseHelper;

  DatabaseHelper get getDatabaseHelper => _getDatabaseHelper;

  accessDatabase(DatabaseHelper db) {
    _getDatabaseHelper = db;
    initializeSuraModels();
    initializeParaModels();
    //notifyListeners();
  }

  // for sura List
  List<SuraModel> _suraList = [];
  List<SuraModel> _allSuraList = [];

  List<SuraModel> get suraModels => _suraList;

  Future<void> initializeSuraModels() async {
    if (_allSuraList.length == 0) {
      _getDatabaseHelper.getAllSuraFromSuraNameTable().then((rows) {
        rows.forEach((row) {
          _suraList.add(SuraModel.formMap(row));
          _allSuraList.add(SuraModel.formMap(row));
        });
      });
      //notifyListeners();
    }
  }

  // for para list

  List<ParaModel> _paraList = [];
  List<ParaModel> _allParaList = [];

  List<ParaModel> get paraList => _paraList;

  Future<void> initializeParaModels() async {
    if (_allParaList.length == 0) {
      _paraList.clear();
      _getDatabaseHelper.getAllParaNameFromTable().then((rows) {
        rows.forEach((row) {
          _paraList.add(ParaModel.formMap(row));
          _allParaList.add(ParaModel.formMap(row));
        });
      });
      //notifyListeners();
    }
  }

  // For Search
  bool _notEmptyText = false;

  bool get notEmptyText => _notEmptyText;
  TextEditingController controller = TextEditingController();

  searchSura(String query) {
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

  searchAyat(String query) {
    if (query.isEmpty) {
      _paraList.clear();
      _paraList = _allParaList;
      _notEmptyText = false;
    } else {
      _notEmptyText = true;
      _paraList = [];
      _allParaList.forEach((paraModel) async {
        if (paraModel.paraNo.toString().contains(query.toLowerCase())) {
          _paraList.add(paraModel);
        }
      });
    }
    notifyListeners();
  }

  clearSearchList({bool isFromSuraScreen = true}) {
    _notEmptyText = false;
    if (isFromSuraScreen) {
      _suraList.clear();
      _suraList = _allSuraList;
    } else {
      _paraList.clear();
      _paraList = _allParaList;
    }

    controller.clear();
    notifyListeners();
  }

  // For Ayat
  List<AyatModel> _getAllAyat = [];

  List<AyatModel> get getAllAyat => _getAllAyat;

  initializeAyatBySuraId(int id) async {
    _getAllAyat.clear();
    _getDatabaseHelper.getAllAyatFromAyatTable(id).then((rows) {
      rows.forEach((row) {
        _getAllAyat.add(AyatModel.formMap(row));
      });
      notifyListeners();
    });
  }

  initializeAyatByParaId(int id) async {
    _getAllAyat.clear();
    _getDatabaseHelper.getAllAyatFromParaTable(id).then((rows) {
      rows.forEach((row) {
        _getAllAyat.add(AyatModel.formMap(row));
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

  playAyatAudio({@required BuildContext context, @required String audioUrl, int index = 0}) async {
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
  AudioPlayer paraPlayer = AudioPlayer();
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
    await paraPlayer.stop();
    notifyListeners();
  }

  initializeAudioModel(int suraNo, String qareName) async {
    _getDatabaseHelper.getAudioBySuraAndQareName(suraNo, qareName).then((rows) async {
      audioModel = rows;
    });
    //notifyListeners();
  }

  cancelDownload() {
    cancelToken.cancel('cancelled');
    notifyListeners();
  }

  playAudioANdDownload({String qareName, String url, BuildContext context, Function percentFunction}) async {
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

  String storagePath = '';
  bool isAvailableFile = false;

  changeAvailableFileStatus() {
    isAvailableFile = false;
    storagePath = '';
  }

  downloadFile({String url, BuildContext context, String fileName, Function percentFunction}) async {
    /// getting application doc directory's path in dir variable

    String dir = (await getExternalStorageDirectory()).path;

    Dio dio = Dio();

    if (await File('$dir/$fileName').exists()) {
      print('$dir/$fileName');
      storagePath = '$dir/$fileName';
      isAvailableFile = true;
      notifyListeners();
    } else {
      showPercentage = 0.0;
      cancelToken = CancelToken();
      showDownloadWidget = true;
      isDownload = true;
      statusCode = 0;
      isAvailableFile = false;
      await dio.download('$url', '$dir/$fileName', onReceiveProgress: (actualBytes, totalBytes) {
        var percentage = actualBytes / totalBytes * 100;
        if (percentage <= 100) {
          showPercentage = percentage / 100;
          print(isDownload);
          if (isDownload) {
            statusCode = 1;
            percentFunction(statusCode);
          }
          isDownload = false;
          downloadMessahge = '${percentage.floor()}';
          print(showPercentage);
          notifyListeners();
          if (percentage == 100) {
            isDownload = true;
            storagePath = '$dir/$fileName';
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

  playAudioByOnline({@required BuildContext context, @required String audioUrl}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          paraPlayer = AudioPlayer();
          suraPlayer.stop();
          ayatPlayer.stop();
          paraPlayer.play(audioUrl);

          paraPlayer.onPlayerStateChanged.listen((s) {
            if (s == AudioPlayerState.PLAYING) {
              isPlaying = true;
              notifyListeners();
            } else if (s == AudioPlayerState.COMPLETED) {
              isPlaying = false;
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

  stopSuraAudioPlayer() async {
    await suraPlayer.stop();
    await ayatPlayer.stop();
    await paraPlayer.stop();
    isPlaying = false;
    saveSuraNo(null);
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

  changeQareName(QareModel qareM) async {
    print(suraNo);
    await _getDatabaseHelper.getAudioBySuraAndQareName(suraNo, qareM.englishName).then((rows) {
      audioModel = rows;
    });
    notifyListeners();
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

  String get getQareName => quraanRepo.getQareNameFromPreference();

  // for Arabic style
  List<KeyModel> _arabyStyles = [];
  KeyModel arabicStyleKeyModel = KeyModel();

  List<KeyModel> get arabyStyles => _arabyStyles;

  initializeAllArabicStyle() {
    if (_arabyStyles.length == 0) {
      _arabyStyles.clear();
      _arabyStyles = quraanRepo.allArabicStyle;
      arabicStyleKeyModel = _arabyStyles.first;
      notifyListeners();
    }
  }

  changeArabicStyle(KeyModel arabicStyle) async {
    arabicStyleKeyModel = arabicStyle;
    await quraanRepo.saveArabicStyleInPreference(arabicStyle.value);
    notifyListeners();
  }

  String get getQuranStyle => quraanRepo.getArabicStyleFromPreference();

  // for Font style
  List<KeyModel> _fontStyles = [];
  KeyModel fontStyleKeyModel = KeyModel();

  List<KeyModel> get fontStyles => _fontStyles;

  initializeAllFontStyle() {
    if (_fontStyles.length == 0) {
      _fontStyles.clear();
      _fontStyles = quraanRepo.allFontStyle;
      fontStyleKeyModel = _fontStyles.first;
      notifyListeners();
    }
  }

  changeFontStyle(KeyModel arabicStyle) async {
    fontStyleKeyModel = arabicStyle;
    await quraanRepo.saveAyatFontStyleInPreference(arabicStyle.keyName);
    notifyListeners();
  }

  String get getFontStyle => quraanRepo.getAyatFontStyleFromPreference();

  // for general Settings

  // for Font Size Range Slider

  double get fontSize => quraanRepo.getAyatFontSizeFromPreference();

  changeFontSize(double value) async {
    await quraanRepo.saveAyatFontSizeInPreference(value);
    notifyListeners();
  }

  // save Sura No
  saveSuraNo(int suraNo) async {
    await quraanRepo.saveSuraNoInPreference(suraNo);
    notifyListeners();
  }

  int get suraNo => quraanRepo.getSuraNoFromPreference();

  // quran sound
  List<QuranWordModels> getAllQuranWords = [];

  Future<void> initializeAllQuranWords() async {
    if (getAllQuranWords.length == 0) {
      _getDatabaseHelper.getAllQuranWordFromTable().then((rows) {
        rows.forEach((row) {
          getAllQuranWords.add(QuranWordModels.fromMap(row));
        });
      });
      notifyListeners();
    }
  }

  // save sura
  SuraModel _suraModel = SuraModel();

  SuraModel get suraModel => _suraModel;

  initializeSuraFromPreference() {
    _suraModel = SuraModel();
    _suraModel = quraanRepo.getSuraNameFromPreference();
    //notifyListeners();
  }

  saveSurToPreference(SuraModel suraModel)async {
    await quraanRepo.saveSuraToPreference(suraModel);
    _suraModel = quraanRepo.getSuraNameFromPreference();
    notifyListeners();
  }
}
