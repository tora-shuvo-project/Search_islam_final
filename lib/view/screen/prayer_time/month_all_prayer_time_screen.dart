import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class MonthAllPrayerTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: Strings.puro_maser_namajer_somoy_suci_dekhun), preferredSize: Size(MediaQuery.of(context).size.width, 120)),
        body: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: [
            Consumer<PrayerTimeProvider>(
              builder: (context, timeProvider, child) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: DataTable(
                  columnSpacing: 25,
                  columns: [
                    DataColumn(label: Text(Strings.date, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(label: Text(Strings.sehri, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(label: Text(Strings.fajr, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(label: Text(Strings.sunrise, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(label: Text(Strings.dhaur, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(label: Text(Strings.asor, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(label: Text(Strings.magrib, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                    DataColumn(label: Text(Strings.isha, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
                  ],
                  rows: timeProvider.prayerTimePojoClass
                      .map((prayerTime) => DataRow(
                      //selected: true,
                      cells: [
                            DataCell(Text('${prayerTime.date}', style: poppinsExtraLight)),
                            DataCell(Text('${prayerTime.sehri}', style: poppinsExtraLight)),
                            DataCell(Text('${prayerTime.fajr}', style: poppinsExtraLight)),
                            DataCell(Text('${prayerTime.sunrise}', style: poppinsExtraLight)),
                            DataCell(Text('${prayerTime.dhur}', style: poppinsExtraLight)),
                            DataCell(Text('${prayerTime.asor}', style: poppinsExtraLight)),
                            DataCell(Text('${prayerTime.magrib}', style: poppinsExtraLight)),
                            DataCell(Text('${prayerTime.isha}', style: poppinsExtraLight)),
                          ]))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
