import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

showprint() {
  print('alarm done');
}

class _TestScreenState extends State<TestScreen> {
  bool isCloseTimer = false;

  closeTimer() {
    setState(() {
      isCloseTimer = true;
    });
  }

  startTime() {
    setState(() {
      isCloseTimer = false;
    });
  }

  showPrint() {
    final myCoordinates = Coordinates(24.0178, 90.4182); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    print("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");

    print('সেহরিঃ ${DateFormat.jm().format(prayerTimes.fajr.subtract(Duration(minutes: 4)))}');

    print(
        'ফজর শুরুঃ ${DateFormat.jm().format(prayerTimes.fajr)}  '
            ' ফজর সেশঃ ${DateFormat.jm().format(prayerTimes.sunrise.subtract(Duration(minutes: 1)))}');
    print(
        'সূর্যদোয় শুরুঃ  ${DateFormat.jm().format(prayerTimes.sunrise)}   '
            'সূর্যদোয় সেশঃ ${DateFormat.jm().format(prayerTimes.sunrise.add(Duration(minutes: 23)))}');
    print(
        'সালাতুল দোহর শুরুঃ  ${DateFormat.jm().format(prayerTimes.sunrise.add(Duration(minutes: 24)))}   '
            'সালাতুল দোহর সেশঃ ${DateFormat.jm().format(prayerTimes.dhuhr.subtract(Duration(minutes: 1)))}');

    print(
        'দোহর শুরুঃ  ${DateFormat.jm().format(prayerTimes.dhuhr)}  '
            ' দোহর সেশঃ ${DateFormat.jm().format(prayerTimes.asr.subtract(Duration(minutes: 1)))}');
    print(
        'আসর শুরুঃ  ${DateFormat.jm().format(prayerTimes.asr)}   '
            'আসর সেশঃ ${DateFormat.jm().format(prayerTimes.maghrib.subtract(Duration(minutes: 4)))}');
    print(
        'মাগরিব  শুরুঃ  ${DateFormat.jm().format(prayerTimes.maghrib)}   '
            'মাগরিব সেশঃ ${DateFormat.jm().format(prayerTimes.isha.subtract(Duration(minutes: 1)))}');
    print('ইফতারঃ  ${DateFormat.jm().format(prayerTimes.maghrib)}');
    print(
        'এশা  শুরুঃ  ${DateFormat.jm().format(prayerTimes.isha)}   '
            'এশা সেশঃ ${DateFormat.jm().format(prayerTimes.fajr.subtract(Duration(minutes: 5)))}');

    int days, hours, minutes, seconds;

    Timer.periodic(Duration(seconds: 1), (timer) {
      Duration eventDuration = DateTime.now().difference(prayerTimes.fajr.add(Duration(hours: 24))).abs();
      if (eventDuration != null) {
        days = eventDuration.inDays;
        hours = eventDuration.inHours - days * 24;
        minutes = eventDuration.inMinutes - (24 * days * 60) - (hours * 60);
        seconds = eventDuration.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
        print('${hours}: ${minutes}: ${seconds}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
            onPressed: startTime,
            icon: Icon(Icons.not_started),
          ),
          IconButton(
            onPressed: closeTimer,
            icon: Icon(Icons.close),
          ),
          OutlineButton(
            child: Text('Alarm now'),
            onPressed: () {
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showPrint,
        child: Icon(Icons.print),
      ),
    );
  }
}
