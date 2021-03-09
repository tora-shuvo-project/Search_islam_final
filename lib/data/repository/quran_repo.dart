import 'package:flutter/material.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/utill/app_constants.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranRepo {
  final SharedPreferences sharedPreferences;

  QuranRepo({@required this.sharedPreferences});

  // Save Qare Name
  Future<void> saveQareNameInPreference(String qareName) async {
    try {
      await sharedPreferences.setString(AppConstants.QARE_NAME, qareName);
    } catch (error) {
      throw error;
    }
  }

  String getQareNameFromPreference() {
    return sharedPreferences.getString(AppConstants.QARE_NAME) ?? 'Abdurrahman Sudais';
  }

  List<QareModel> qareodels = [
    QareModel(banglaName: Strings.abdur_rahman_sudaies_bangla, englishName: Strings.abdur_rahman_sudaies_english),
    QareModel(banglaName: Strings.sad_al_gamidi_bangla, englishName: Strings.sad_al_gamidi_english),
    QareModel(banglaName: Strings.misare_bin_rased_al_afsi_bangla, englishName: Strings.misare_bin_rased_al_afsi_english),
    QareModel(banglaName: Strings.salah_budir_bangla, englishName: Strings.salah_budir_english),
    QareModel(banglaName: Strings.ahmed_al_ajimi_bangla, englishName: Strings.ahmed_al_ajimi_english),
  ];
}
