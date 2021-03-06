
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_islam/helper/bangla_utilities.dart';
import 'package:search_islam/helper/hijri_calendar/hijri_calendar.dart';

class HomeProvider with ChangeNotifier {
  String banglaDate;
  String arabyDate;
  String englishDate;
  String banglaDateWithMessage;
  String arabyDateWithMessage;
  String englishDateWithMessage;
  String dayName;

  initializeAllDate() {
    var _today = new HijriCalendar.now();
    banglaDate = BanglaUtility.getBanglaDate(day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year);
    arabyDate = _today.toFormat("dd MMMM,yyyy");
    englishDate = DateFormat('dd MMMM,yyyy').format(DateTime.now());
    dayName = DateFormat('EEEE').format(DateTime.now());
    banglaDateWithMessage='Today: $banglaDate';
    arabyDateWithMessage='Today: $arabyDate';
    englishDateWithMessage='Today: $englishDate';
    //notifyListeners();
  }

  List<String> allDate() {
    List<String> _getAllDateData = [banglaDateWithMessage, englishDateWithMessage, arabyDateWithMessage];
    return _getAllDateData;
  }


}
