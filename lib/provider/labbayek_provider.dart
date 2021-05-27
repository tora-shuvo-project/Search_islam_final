import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:search_islam/data/model/labbayek_model.dart';
import 'package:search_islam/data/repository/labbayek_repo.dart';

class LabbayekProvider with ChangeNotifier {
  final LabbayekRepo labbayekRepo;

  LabbayekProvider({this.labbayekRepo});

  List<LabbayekModel> _labbayeks = [];

  List<LabbayekModel> get labbayeks => _labbayeks;
  LabbayekModel labbayekModel;

  initializeLabbayek() {
    if (_labbayeks.length == 0) {
      _labbayeks.clear();
      _labbayeks = labbayekRepo.getAllLabbayeks;
      labbayekModel = labbayekRepo.getAllLabbayeks.first;
      notifyListeners();
    }
  }

  changeLabbayekModel(LabbayekModel lbModel) async {
    labbayekModel = lbModel;
    await labbayekPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }

  AudioPlayer labbayekPlayer = AudioPlayer();
  bool isPlaying = false;
  double showPercentage = 0.0;
  String downloadMessahge = '0';
  bool isDownload = false;
  CancelToken cancelToken = CancelToken();
  bool showDownloadWidget = false;
  int statusCode = 0;

  downloadFile({String url, BuildContext context, String fileName, Function percentFunction}) async {
    /// getting application doc directory's path in dir variable

    String dir = (await getExternalStorageDirectory()).path;

    Dio dio = Dio();

    if (await File('$dir/$fileName').exists()) {
      print('$dir/$fileName');
      showDownloadWidget = false;
      isPlaying = !isPlaying;

      if (isPlaying) {
        labbayekPlayer.play('$dir/$fileName');
      } else {
        labbayekPlayer.pause();
      }

      labbayekPlayer.onPlayerStateChanged.listen((s) {
        if (s == AudioPlayerState.COMPLETED) {
          isPlaying = true;
          labbayekPlayer.stop();
          labbayekPlayer.play('$dir/$fileName');
          notifyListeners();
        }
      });

      notifyListeners();
    } else {
      showPercentage = 0.0;
      cancelToken = CancelToken();
      showDownloadWidget = true;
      isDownload = true;
      statusCode = 0;

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
            //labbayekPlayer.play('$dir/$fileName');
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

  cancelDownload() {
    cancelToken.cancel('cancelled');
    notifyListeners();
  }

  stopAudio() async {
    await labbayekPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }
}
