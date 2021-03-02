import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeCurrentPrayerTime();
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PrayerTimeProvider>(
        builder: (context, timeProvider, child) => ListView(
          children: [
            Center(child: Text('Sehri ${timeProvider.sehriTime}')),
            Center(child: Text('fojor  ${timeProvider.fajrTimeStart} To ${timeProvider.fajrTimeEnd}')),
            Center(child: Text('Sunrise ${timeProvider.sunriseTimeStart} To ${timeProvider.sunriseTimeEnd}')),
            Center(child: Text('Salatul Dhahr ${timeProvider.salatulDhahrTimeStart} To ${timeProvider.salatulDhahrTimeEnd}')),
            Center(child: Text('Dhahr ${timeProvider.dhahrTimeStart} To ${timeProvider.dhahrTimeEnd}')),
            Center(child: Text('Asr ${timeProvider.asrTimeStart} To ${timeProvider.asrTimeEnd}')),
            Center(child: Text('Magrib ${timeProvider.magribTimeStart} To ${timeProvider.magribTimeEnd}')),
            Center(child: Text('Isha ${timeProvider.ishaTimeStart} To ${timeProvider.ishaTimeEnd}')),
            Center(child: Text('বাকি আছে  ${timeProvider.hours}:${timeProvider.minutes}:${timeProvider.seconds}')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(
                children: [
                  Center(child: Text('বর্তমান ওয়াক্তঃ  ${timeProvider.currentPrayerName}')),
                  Center(child: Text(timeProvider.currentPrayerTime)),
                ],
              ),
              Column(
                children: [
                  Center(child: Text('পরবর্তি ওয়াক্তঃ  ${timeProvider.nextPrayerName}')),
                  Center(child: Text(timeProvider.nextPrayerTime)),
                ],
              ),
            ],),

          ],
        ),
      ),
    );
  }
}
