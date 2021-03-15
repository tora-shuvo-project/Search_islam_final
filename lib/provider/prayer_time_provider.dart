import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/foundation.dart';
import 'package:search_islam/data/repository/location_repo.dart';
import 'package:search_islam/helper/date_converter.dart';
import 'package:search_islam/utill/string_resources.dart';

class PrayerTimeProvider with ChangeNotifier {

  final LocationRepo locationRepo;

  PrayerTimeProvider({this.locationRepo});

  String sehriTime = '';
  String fajrTimeStart = '';
  String fajrTimeEnd = '';
  String sunriseTimeStart = '';
  String sunriseTime = '';
  String sunriseTimeEnd = '';
  String salatulDhahrTimeStart = '';
  String salatulDhahrTimeEnd = '';
  String dhahrTimeStart = '';
  String dhahrTimeEnd = '';
  String asrTimeStart = '';
  String asrTimeEnd = '';
  String magribTimeStart = '';
  String magribTimeEnd = '';
  String ifTarTime = '';
  String ishaTimeStart = '';
  String ishaTimeEnd = '';
  String currentPrayerTimeStart = '';
  String currentPrayerTimeEnd = '';
  String nextPrayerTime = '';
  String currentPrayerName = '';
  String nextPrayerName = '';
  int selectCurrentPrayerCode = -1;

  PrayerTimes currentPrayerTimes;

  initializeCurrentPrayerTime() {
    final myCoordinates = Coordinates(locationRepo.getLatitude(), locationRepo.getLongitude());
    final params = CalculationMethod.karachi.getParameters()..madhab = Madhab.hanafi;
    currentPrayerTimes = PrayerTimes.today(myCoordinates, params);

    sehriTime = DateConverter.formatDateHHMMAA(currentPrayerTimes.fajr.subtract(Duration(minutes: 4)));
    fajrTimeStart = DateConverter.formatDateHHMM(currentPrayerTimes.fajr);
    fajrTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.sunrise.subtract(Duration(minutes: 1)));
    sunriseTime = DateConverter.formatDateHHMMAA(currentPrayerTimes.sunrise);
    sunriseTimeStart = DateConverter.formatDateHHMM(currentPrayerTimes.sunrise);
    sunriseTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.sunrise.add(Duration(minutes: 23)));
    salatulDhahrTimeStart = DateConverter.formatDateHHMM(currentPrayerTimes.sunrise.add(Duration(minutes: 24)));
    salatulDhahrTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.dhuhr.subtract(Duration(minutes: 1)));

    dhahrTimeStart = DateConverter.formatDateHHMM(currentPrayerTimes.dhuhr);
    dhahrTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.asr.subtract(Duration(minutes: 1)));
    asrTimeStart = DateConverter.formatDateHHMM(currentPrayerTimes.asr);
    asrTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4)));
    ifTarTime = DateConverter.formatDateHHMMAA(currentPrayerTimes.maghrib);
    magribTimeStart = DateConverter.formatDateHHMM(currentPrayerTimes.maghrib);
    magribTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.isha.subtract(Duration(minutes: 1)));
    ishaTimeStart = DateConverter.formatDateHHMM(currentPrayerTimes.isha);
    ishaTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.fajr.subtract(Duration(minutes: 5)));

    checkPrayerTimeCondition();
    //notifyListeners();
  }

  int days;
  int hours;
  int minutes;
  int seconds;
  int iftarSehriDays;
  int iftarSehriHours;
  int iftarSehriMinutes;
  int iftarSehriSeconds;
  String statusSehriIftar = '';
  int dayIndex = 0;

  checkPrayerTimeCondition() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (DateTime.now().isAfter(currentPrayerTimes.fajr.subtract(Duration(minutes: 4))) && DateTime.now().isBefore(currentPrayerTimes.maghrib)) {
        timeCalculationForSehriIftar(DateTime.now().difference(currentPrayerTimes.maghrib).abs(), Strings.iftar);
      } else {
        timeCalculationForSehriIftar(DateTime.now().difference(currentPrayerTimes.fajr.add(Duration(hours: 24))).abs(), Strings.sehri);
      }

      if (DateTime.now().isBefore(currentPrayerTimes.fajr.subtract(Duration(minutes: 4))) &&
          DateTime.now().isAfter(currentPrayerTimes.fajr.subtract(Duration(hours: 1)))) {
        selectCurrentPrayerCode = -1;
        checkCurrentAndNextPrayerTime(currentPrayerTimes.fajr.subtract(Duration(minutes: 4)), 'নফল', currentPrayerTimes.fajr, 'ফজর');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.fajr.subtract(Duration(minutes: 4))).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.fajr);
      } else if (DateTime.now().isBefore(currentPrayerTimes.sunrise.subtract(Duration(minutes: 1))) &&
          DateTime.now().isAfter(currentPrayerTimes.fajr)) {
        selectCurrentPrayerCode = 1;
        checkCurrentAndNextPrayerTime(currentPrayerTimes.fajr, 'ফজর', currentPrayerTimes.sunrise, 'সূর্যোদয়');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.sunrise.subtract(Duration(minutes: 1))).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.sunrise.subtract(Duration(minutes: 1)));
      } else if ((DateTime.now().isBefore(currentPrayerTimes.sunrise.add(Duration(minutes: 23)))) &&
          (DateTime.now().isAfter(currentPrayerTimes.sunrise) || DateTime.now() == currentPrayerTimes.sunrise)) {
        selectCurrentPrayerCode = -1;
        checkCurrentAndNextPrayerTime(
            currentPrayerTimes.sunrise, 'নামাজের জন্য হারাম', currentPrayerTimes.sunrise.add(Duration(minutes: 23)), 'সালাতুল দোহা');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.sunrise.add(Duration(minutes: 24))).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.sunrise.add(Duration(minutes: 23)));
      } else if ((DateTime.now().hour == currentPrayerTimes.sunrise.add(Duration(minutes: 23)).hour) &&
          (DateTime.now().minute == currentPrayerTimes.sunrise.add(Duration(minutes: 23)).minute)) {
        selectCurrentPrayerCode = -1;
        checkCurrentAndNextPrayerTime(
            currentPrayerTimes.sunrise, 'নামাজের জন্য হারাম', currentPrayerTimes.sunrise.add(Duration(minutes: 23)), 'সালাতুল দোহা');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.sunrise.add(Duration(minutes: 24))).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.sunrise.add(Duration(minutes: 23)));
      } else if (DateTime.now().isBefore(currentPrayerTimes.dhuhr.subtract(Duration(minutes: 1))) &&
          (DateTime.now().isAfter(currentPrayerTimes.sunrise.add(Duration(minutes: 24))))) {
        selectCurrentPrayerCode = -2;
        checkCurrentAndNextPrayerTime(currentPrayerTimes.sunrise.add(Duration(minutes: 24)), 'সালাতুল দোহা', currentPrayerTimes.dhuhr, 'যোহর');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.dhuhr.subtract(Duration(minutes: 1))).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.dhuhr.subtract(Duration(minutes: 1)));
      } else if (DateTime.now().isBefore(currentPrayerTimes.asr) &&
          (DateTime.now().isAfter(currentPrayerTimes.dhuhr) || DateTime.now() == currentPrayerTimes.dhuhr)) {
        selectCurrentPrayerCode = 2;
        checkCurrentAndNextPrayerTime(currentPrayerTimes.dhuhr, 'যোহর', currentPrayerTimes.asr, 'আছর');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.asr).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.asr.subtract(Duration(minutes: 1)));
      } else if (DateTime.now().isBefore(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4))) &&
          (DateTime.now().isAfter(currentPrayerTimes.asr) || DateTime.now() == currentPrayerTimes.asr)) {
        selectCurrentPrayerCode = 3;
        checkCurrentAndNextPrayerTime(currentPrayerTimes.asr, 'আছর', currentPrayerTimes.maghrib.subtract(Duration(minutes: 4)), 'নামাজের জন্য হারাম');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4))).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4)));
      } else if (DateTime.now().isBefore(currentPrayerTimes.maghrib) &&
          (DateTime.now().isAfter(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4))))) {
        selectCurrentPrayerCode = -1;
        checkCurrentAndNextPrayerTime(
            currentPrayerTimes.maghrib.subtract(Duration(minutes: 4)), 'নামাজের জন্য হারাম', currentPrayerTimes.maghrib, 'মাগরিব');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.maghrib).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.maghrib);
      } else if (DateTime.now().isBefore(currentPrayerTimes.isha) &&
          (DateTime.now().isAfter(currentPrayerTimes.maghrib) || DateTime.now() == currentPrayerTimes.maghrib)) {
        selectCurrentPrayerCode = 4;
        checkCurrentAndNextPrayerTime(currentPrayerTimes.maghrib, 'মাগরিব', currentPrayerTimes.isha, 'ইশা');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.isha).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.isha.subtract(Duration(minutes: 1)));
      } else {
        selectCurrentPrayerCode = 5;
        checkCurrentAndNextPrayerTime(currentPrayerTimes.isha, 'ইশা', currentPrayerTimes.fajr.subtract(Duration(minutes: 4)), 'নফল');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.fajr.add(Duration(hours: 24))).abs());
        currentPrayerTimeEnd = DateConverter.formatDateHHMM(currentPrayerTimes.fajr.subtract(Duration(minutes: 5)));
      }
      dayIndex = DateTime.now().day;
      notifyListeners();
    });
  }

  checkCurrentAndNextPrayerTime(DateTime cPrayerTime, String cPrayerName, DateTime nPrayerTime, String nPrayerName) {
    currentPrayerTimeStart = DateConverter.formatDateHHMM(cPrayerTime);
    currentPrayerName = '$cPrayerName';
    nextPrayerName = '$nPrayerName';
    nextPrayerTime = DateConverter.formatDateHHMM(nPrayerTime);
    notifyListeners();
  }

  timeCalculation(Duration duration) {
    if (duration != null) {
      days = duration.inDays;
      hours = duration.inHours - days * 24;
      minutes = duration.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = duration.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    }

    notifyListeners();
  }

  timeCalculationForSehriIftar(Duration duration, String status) {
    if (duration != null) {
      iftarSehriDays = duration.inDays;
      iftarSehriHours = duration.inHours - iftarSehriDays * 24;
      iftarSehriMinutes = duration.inMinutes - (24 * iftarSehriDays * 60) - (iftarSehriHours * 60);
      iftarSehriSeconds = duration.inSeconds - (24 * iftarSehriDays * 60 * 60) - (iftarSehriHours * 60 * 60) - (iftarSehriMinutes * 60);
      statusSehriIftar = status;
    }

    notifyListeners();
  }

  // get Tommorw Prayer Time

  String tommorwSehriTime = '';
  String tommorwFajrTimeStart = '';
  String tommorwFajrTimeEnd = '';
  String tommorwSunriseTimeStart = '';
  String tommorwSunriseTime = '';
  String tommorwSunriseTimeEnd = '';
  String tommorwSalatulDhahrTimeStart = '';
  String tommorwSalatulDhahrTimeEnd = '';
  String tommorwDhahrTimeStart = '';
  String tommorwDhahrTimeEnd = '';
  String tommorwAsrTimeStart = '';
  String tommorwAsrTimeEnd = '';
  String tommorwMagribTimeStart = '';
  String tommorwMagribTimeEnd = '';
  String tommorwIfTarTime = '';
  String tommorwIshaTimeStart = '';
  String tommorwIshaTimeEnd = '';

  initializeTommorwPrayerTime() {
    final myCoordinates = Coordinates(locationRepo.getLatitude(), locationRepo.getLongitude());
    final params = CalculationMethod.karachi.getParameters()..madhab = Madhab.hanafi;
    final nextPrayerTimes = PrayerTimes.getByDatePrayerTime(myCoordinates, params, DateTime.now().add(Duration(days: 1)));

    tommorwSehriTime = DateConverter.formatDateHHMMAA(nextPrayerTimes.fajr.subtract(Duration(minutes: 4)));
    tommorwFajrTimeStart = DateConverter.formatDateHHMM(nextPrayerTimes.fajr);
    tommorwFajrTimeEnd = DateConverter.formatDateHHMM(nextPrayerTimes.sunrise.subtract(Duration(minutes: 1)));
    tommorwSunriseTime = DateConverter.formatDateHHMMAA(nextPrayerTimes.sunrise);
    tommorwSunriseTimeStart = DateConverter.formatDateHHMM(nextPrayerTimes.sunrise);
    tommorwSunriseTimeEnd = DateConverter.formatDateHHMM(nextPrayerTimes.sunrise.add(Duration(minutes: 23)));
    tommorwSalatulDhahrTimeStart = DateConverter.formatDateHHMM(nextPrayerTimes.sunrise.add(Duration(minutes: 24)));
    tommorwSalatulDhahrTimeEnd = DateConverter.formatDateHHMM(nextPrayerTimes.dhuhr.subtract(Duration(minutes: 1)));
    tommorwDhahrTimeStart = DateConverter.formatDateHHMM(nextPrayerTimes.dhuhr);
    tommorwDhahrTimeEnd = DateConverter.formatDateHHMM(nextPrayerTimes.asr.subtract(Duration(minutes: 1)));
    tommorwAsrTimeStart = DateConverter.formatDateHHMM(nextPrayerTimes.asr);
    tommorwAsrTimeEnd = DateConverter.formatDateHHMM(nextPrayerTimes.maghrib.subtract(Duration(minutes: 4)));
    tommorwIfTarTime = DateConverter.formatDateHHMMAA(nextPrayerTimes.maghrib);
    tommorwMagribTimeStart = DateConverter.formatDateHHMM(nextPrayerTimes.maghrib);
    tommorwMagribTimeEnd = DateConverter.formatDateHHMM(nextPrayerTimes.isha.subtract(Duration(minutes: 1)));
    tommorwIshaTimeStart = DateConverter.formatDateHHMM(nextPrayerTimes.isha);
    tommorwIshaTimeEnd = DateConverter.formatDateHHMM(nextPrayerTimes.fajr.subtract(Duration(minutes: 5)));

    notifyListeners();
  }

  // for get Number of days of all month

  int monthLength = 0;

  void checkDaysInMonth() {
    var firstDayThisMonth = new DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
    monthLength = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    notifyListeners();
  }

// get All month Prayer Time
  List<PrayerTimePojoClass> prayerTimePojoClass = [];

  initializeAllMonthPrayerTimeData() {
    final myCoordinates = Coordinates(locationRepo.getLatitude(), locationRepo.getLongitude());
    final params = CalculationMethod.karachi.getParameters()..madhab = Madhab.hanafi;

    prayerTimePojoClass = [];

    for (int i = 0; i < monthLength; i++) {
      final nextPrayerTimes = PrayerTimes.getByDatePrayerTime(myCoordinates, params, DateTime(DateTime.now().year, DateTime.now().month, i + 1));
      prayerTimePojoClass.add(PrayerTimePojoClass(
          i + 1,
          DateConverter.formatDateMMDD(DateTime(DateTime.now().year, DateTime.now().month, i + 1)),
          DateConverter.formatDateHHMMAA(nextPrayerTimes.fajr.subtract(Duration(minutes: 4))),
          DateConverter.formatDateHHMMAA(nextPrayerTimes.fajr),
          DateConverter.formatDateHHMMAA(nextPrayerTimes.sunrise),
          DateConverter.formatDateHHMMAA(nextPrayerTimes.dhuhr),
          DateConverter.formatDateHHMMAA(nextPrayerTimes.asr),
          DateConverter.formatDateHHMMAA(nextPrayerTimes.maghrib),
          DateConverter.formatDateHHMMAA(nextPrayerTimes.isha)));
    }
    notifyListeners();
  }


}

class PrayerTimePojoClass {
  int selectIndex;
  String date;
  String sehri;
  String fajr;
  String sunrise;
  String dhur;
  String asor;
  String magrib;
  String isha;

  PrayerTimePojoClass(this.selectIndex, this.date, this.sehri, this.fajr, this.sunrise, this.dhur, this.asor, this.magrib, this.isha);
}
