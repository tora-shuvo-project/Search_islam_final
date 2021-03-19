import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/data/model/key_model.dart';
import 'package:search_islam/data/model/sura_model.dart';
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

  // Save Sura No
  Future<void> saveSuraNoInPreference(int suraNo) async {
    try {
      await sharedPreferences.setInt(AppConstants.SAVE_SURA_NO, suraNo);
    } catch (error) {
      throw error;
    }
  }

  int getSuraNoFromPreference() {
    return sharedPreferences.getInt(AppConstants.SAVE_SURA_NO) ?? 0;
  }

  // for general ayat style
  Future<void> saveArabicInPreference(bool value) async {
    try {
      await sharedPreferences.setBool(AppConstants.SHOW_AYAT_ARABIC, value);
    } catch (error) {
      throw error;
    }
  }

  bool getArabicFromPreference() {
    return sharedPreferences.getBool(AppConstants.SHOW_AYAT_ARABIC) ?? true;
  }

  Future<void> saveBanglaMeaningInPreference(bool value) async {
    try {
      await sharedPreferences.setBool(AppConstants.SHOW_AYAT_BANGLA_MEANING, value);
    } catch (error) {
      throw error;
    }
  }

  bool getBanglaMeaningFromPreference() {
    return sharedPreferences.getBool(AppConstants.SHOW_AYAT_BANGLA_MEANING) ?? true;
  }

  Future<void> saveBanglaTranslatorInPreference(bool value) async {
    try {
      await sharedPreferences.setBool(AppConstants.SHOW_AYAT_BANGLA_TRANSLATOR, value);
    } catch (error) {
      throw error;
    }
  }

  bool getBanglaTranslatorFromPreference() {
    return sharedPreferences.getBool(AppConstants.SHOW_AYAT_BANGLA_TRANSLATOR) ?? true;
  }

  // font size
  Future<void> saveAyatFontSizeInPreference(double value) async {
    try {
      await sharedPreferences.setDouble(AppConstants.SHOW_AYAT_FONT_SIZE, value);
    } catch (error) {
      throw error;
    }
  }

  double getAyatFontSizeFromPreference() {
    return sharedPreferences.getDouble(AppConstants.SHOW_AYAT_FONT_SIZE) ?? 18.0;
  }

  // font style
  Future<void> saveAyatFontStyleInPreference(String value) async {
    try {
      await sharedPreferences.setString(AppConstants.SHOW_AYAT_FONT_STYLE, value);
    } catch (error) {
      throw error;
    }
  }

  String getAyatFontStyleFromPreference() {
    return sharedPreferences.getString(AppConstants.SHOW_AYAT_FONT_STYLE) ?? 'Maddina';
  }

  // Arabic Style
  Future<void> saveArabicStyleInPreference(String value) async {
    try {
      await sharedPreferences.setString(AppConstants.SHOW_AYAT_ARABIC_STYLE, value);
    } catch (error) {
      throw error;
    }
  }

  String getArabicStyleFromPreference() {
    return sharedPreferences.getString(AppConstants.SHOW_AYAT_ARABIC_STYLE) ?? 'Arabi Utmanic';
  }

  // save sura

  SuraModel getSuraNameFromPreference() {
    return SuraModel.formMap(jsonDecode(sharedPreferences.getString(AppConstants.SAVE_SURA) ??
        "{\"AYATNO\":\"৭\",\"SURANO\":1,\"PARANO\":\"\\t1\",\"ARABISURANAME\":\"\الفاتحة\",\"BANGLAMEANING\":\"সূচনা\",\"BANGLATRANSLATOR\":\"আল ফাতিহা\",\"OBOTIRNO\":\"মক্কা\",\"ENGLISHSURANAME\":\"Al-Faatiha\",\"KEYNAME\":\"\\tFatiha\"}"));
  }

  Future<void> saveSuraToPreference(SuraModel suraModel) async {
    try {
      await sharedPreferences.setString(AppConstants.SAVE_SURA, jsonEncode(suraModel.tomap()));
    } catch (error) {
      throw error;
    }

  }

  List<QareModel> qareodels = [
    QareModel(banglaName: Strings.abdur_rahman_sudaies_bangla, englishName: Strings.abdur_rahman_sudaies_english),
    QareModel(banglaName: Strings.sad_al_gamidi_bangla, englishName: Strings.sad_al_gamidi_english),
    QareModel(banglaName: Strings.misare_bin_rased_al_afsi_bangla, englishName: Strings.misare_bin_rased_al_afsi_english),
    QareModel(banglaName: Strings.salah_budir_bangla, englishName: Strings.salah_budir_english),
    QareModel(banglaName: Strings.ahmed_al_ajimi_bangla, englishName: Strings.ahmed_al_ajimi_english),
  ];

  List<KeyModel> allArabicStyle = [
    KeyModel(keyName: Strings.araby_simple_bangla, value: Strings.araby_simple_english),
    KeyModel(keyName: Strings.araby_uth_manik_bangla, value: Strings.araby_uth_manik_english),
    KeyModel(keyName: Strings.araby_indopak_bangla, value: Strings.araby_indopak_english),
  ];
  List<KeyModel> allFontStyle = [
    KeyModel(keyName: Strings.monserat_font_english, value: Strings.monserat_font_bangla),
    KeyModel(keyName: Strings.mukadimh_font_english, value: Strings.mukadimh_font_bangla),
    KeyModel(keyName: Strings.qalam_majid_font_english, value: Strings.qalam_majid_font_bangla),
    KeyModel(keyName: Strings.utman_font_english, value: Strings.utman_font_bangla),
    KeyModel(keyName: Strings.madina_font_english, value: Strings.madina_font_bangla),
  ];
}
