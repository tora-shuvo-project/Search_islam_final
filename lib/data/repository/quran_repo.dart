import 'package:flutter/material.dart';
import 'package:search_islam/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranRepo{
  final SharedPreferences sharedPreferences;

  QuranRepo({@required this.sharedPreferences});

  // Save Qare Name
  Future<void> saveQareNameInPreference(String qareName)async{
    try{
      await sharedPreferences.setString(AppConstants.QARE_NAME, qareName);
    }catch(error){
      throw error;
    }
  }

  String getQareNameFromPreference(){
    return  sharedPreferences.getString(AppConstants.QARE_NAME)??'Abdurrahman Sudais';
  }
}