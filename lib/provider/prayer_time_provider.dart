import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class PrayerTimeProvider with ChangeNotifier {
  String sehriTime = '';
  String fajrTimeStart = '';
  String fajrTimeEnd = '';
  String sunriseTimeStart = '';
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
  String nextPrayerTime = '';
  String currentPrayerName = '';
  String nextPrayerName = '';

  PrayerTimes currentPrayerTimes;

  initializeCurrentPrayerTime() {
    final myCoordinates = Coordinates(24.0178, 90.4182); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    currentPrayerTimes = PrayerTimes.today(myCoordinates, params);

    sehriTime = DateFormat.jm().format(currentPrayerTimes.fajr.subtract(Duration(minutes: 4)));
    fajrTimeStart = DateFormat.jm().format(currentPrayerTimes.fajr);
    fajrTimeEnd = DateFormat.jm().format(currentPrayerTimes.sunrise.subtract(Duration(minutes: 1)));
    sunriseTimeStart = DateFormat.jm().format(currentPrayerTimes.sunrise);
    sunriseTimeEnd = DateFormat.jm().format(currentPrayerTimes.sunrise.add(Duration(minutes: 23)));
    salatulDhahrTimeStart = DateFormat.jm().format(currentPrayerTimes.sunrise.add(Duration(minutes: 24)));
    salatulDhahrTimeEnd = DateFormat.jm().format(currentPrayerTimes.dhuhr.subtract(Duration(minutes: 1)));
    dhahrTimeStart = DateFormat.jm().format(currentPrayerTimes.dhuhr);
    dhahrTimeEnd = DateFormat.jm().format(currentPrayerTimes.asr.subtract(Duration(minutes: 1)));
    asrTimeStart = DateFormat.jm().format(currentPrayerTimes.asr);
    asrTimeEnd = DateFormat.jm().format(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4)));
    ifTarTime = DateFormat.jm().format(currentPrayerTimes.maghrib);
    magribTimeStart = DateFormat.jm().format(currentPrayerTimes.maghrib);
    magribTimeEnd = DateFormat.jm().format(currentPrayerTimes.isha.subtract(Duration(minutes: 1)));
    ishaTimeStart = DateFormat.jm().format(currentPrayerTimes.isha);
    ishaTimeEnd = DateFormat.jm().format(currentPrayerTimes.fajr.subtract(Duration(minutes: 5)));

    checkPrayerTimeCondition();
    //notifyListeners();
  }

  int days;
  int hours;
  int minutes;
  int seconds;

  checkPrayerTimeCondition() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (DateTime.now().isBefore(currentPrayerTimes.fajr.subtract(Duration(minutes: 4))) &&
          DateTime.now().isAfter(currentPrayerTimes.fajr.subtract(Duration(hours: 1)))) {
        checkCurrentAndNextPrayerTime(currentPrayerTimes.fajr.subtract(Duration(minutes: 4)), 'নফল', currentPrayerTimes.fajr, 'ফজর');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.fajr.subtract(Duration(minutes: 4))).abs());
      } else if (DateTime.now().isBefore(currentPrayerTimes.sunrise.subtract(Duration(minutes: 1))) &&
          DateTime.now().isAfter(currentPrayerTimes.fajr)) {
        checkCurrentAndNextPrayerTime(currentPrayerTimes.fajr, 'ফজর', currentPrayerTimes.sunrise, 'সূর্যোদয়');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.sunrise.subtract(Duration(minutes: 1))).abs());
      } else if ((DateTime.now().isBefore(currentPrayerTimes.sunrise.add(Duration(minutes: 23)))) &&
          (DateTime.now().isAfter(currentPrayerTimes.sunrise) || DateTime.now() == currentPrayerTimes.sunrise)) {
        checkCurrentAndNextPrayerTime(
            currentPrayerTimes.sunrise, 'নামাজের জন্য হারাম', currentPrayerTimes.sunrise.add(Duration(minutes: 23)), 'সালাতুল দোহা');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.sunrise.add(Duration(minutes: 24))).abs());
      } else if ((DateTime.now().hour == currentPrayerTimes.sunrise.add(Duration(minutes: 23)).hour) &&
          (DateTime.now().minute == currentPrayerTimes.sunrise.add(Duration(minutes: 23)).minute)) {
        checkCurrentAndNextPrayerTime(
            currentPrayerTimes.sunrise, 'নামাজের জন্য হারাম', currentPrayerTimes.sunrise.add(Duration(minutes: 23)), 'সালাতুল দোহা');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.sunrise.add(Duration(minutes: 24))).abs());
      } else if (DateTime.now().isBefore(currentPrayerTimes.dhuhr.subtract(Duration(minutes: 1))) &&
          (DateTime.now().isAfter(currentPrayerTimes.sunrise.add(Duration(minutes: 24))))) {
        checkCurrentAndNextPrayerTime(currentPrayerTimes.sunrise.add(Duration(minutes: 24)), 'সালাতুল দোহা', currentPrayerTimes.dhuhr, 'যোহর');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.dhuhr.subtract(Duration(minutes: 1))).abs());
      } else if (DateTime.now().isBefore(currentPrayerTimes.asr) &&
          (DateTime.now().isAfter(currentPrayerTimes.dhuhr) || DateTime.now() == currentPrayerTimes.dhuhr)) {
        checkCurrentAndNextPrayerTime(currentPrayerTimes.dhuhr, 'যোহর', currentPrayerTimes.asr, 'আছর');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.asr).abs());
      } else if (DateTime.now().isBefore(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4))) &&
          (DateTime.now().isAfter(currentPrayerTimes.asr) || DateTime.now() == currentPrayerTimes.asr)) {
        checkCurrentAndNextPrayerTime(currentPrayerTimes.asr, 'আছর', currentPrayerTimes.maghrib.subtract(Duration(minutes: 4)), 'নামাজের জন্য হারাম');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4))).abs());
      } else if (DateTime.now().isBefore(currentPrayerTimes.maghrib) &&
          (DateTime.now().isAfter(currentPrayerTimes.maghrib.subtract(Duration(minutes: 4))))) {
        checkCurrentAndNextPrayerTime(
            currentPrayerTimes.maghrib.subtract(Duration(minutes: 4)), 'নামাজের জন্য হারাম', currentPrayerTimes.maghrib, 'মাগরিব');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.maghrib).abs());
      } else if (DateTime.now().isBefore(currentPrayerTimes.isha) &&
          (DateTime.now().isAfter(currentPrayerTimes.maghrib) || DateTime.now() == currentPrayerTimes.maghrib)) {
        checkCurrentAndNextPrayerTime(currentPrayerTimes.maghrib, 'মাগরিব', currentPrayerTimes.isha, 'ইশা');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.isha).abs());
      } else {
        checkCurrentAndNextPrayerTime(currentPrayerTimes.isha, 'ইশা', currentPrayerTimes.fajr.subtract(Duration(minutes: 4)), 'নফল');
        timeCalculation(DateTime.now().difference(currentPrayerTimes.fajr.add(Duration(hours: 24))).abs());
      }
      notifyListeners();
    });
  }

  checkCurrentAndNextPrayerTime(DateTime cPrayerTime, String cPrayerName, DateTime nPrayerTime, String nPrayerName) {
    currentPrayerTimeStart = DateFormat.jm().format(cPrayerTime);
    currentPrayerName = '$cPrayerName';
    nextPrayerName = '$nPrayerName';
    nextPrayerTime = DateFormat.jm().format(nPrayerTime);
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
}
