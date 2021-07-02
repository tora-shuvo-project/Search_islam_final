import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class MonthAllPrayerTimeScreen extends StatelessWidget {
  Widget titleWidget(String key, String value, {double top = 3, double bottom = 0, int indexValue = 0, bool isSelectedScreen = false}) {
    return value != null
        ? Container(
            padding: EdgeInsets.only(top: top),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                    child: Text(
                      '${convertEngToBangla(indexValue)}',
                      style: poppinsExtraLight.copyWith(color: isSelectedScreen ? Colors.black : Colors.white),
                    ),
                    radius: 12,
                    backgroundColor: isSelectedScreen ? Colors.white : Colors.blueGrey),
                SizedBox(width: 10),
                Text(key ?? '', style: kalpurus.copyWith(fontSize: 18, color: isSelectedScreen ? Colors.white : Colors.blueGrey)),
                SizedBox(width: 10),
                Expanded(
                    flex: 4,
                    child: Text(value ?? '', style: poppinsRegular.copyWith(fontSize: 16, color: isSelectedScreen ? Colors.white : Colors.black)))
              ],
            ),
          )
        : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: Strings.puro_maser_namajer_somoy_suci_dekhun), preferredSize: Size(MediaQuery.of(context).size.width, 120)),
        body: Consumer<PrayerTimeProvider>(
          builder: (context, timeProvider, child) => ListView.builder(
              itemCount: timeProvider.prayerTimePojoClass.length,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: timeProvider.dayIndex == index + 1 ? Colors.green : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text('${timeProvider.prayerTimePojoClass[index].date}-${DateTime.now().year}',
                            style: poppinsSemiBold.copyWith(color: timeProvider.dayIndex == index + 1 ? Colors.white : Colors.green)),
                        Divider(color: timeProvider.dayIndex == index + 1 ? Colors.white : Colors.grey.withOpacity(.4)),
                        titleWidget('${Strings.sehri}:', timeProvider.prayerTimePojoClass[index].sehri,
                            indexValue: 1, isSelectedScreen: timeProvider.dayIndex == index + 1 ? true : false),
                        titleWidget('${Strings.fajr}:', timeProvider.prayerTimePojoClass[index].fajr,
                            indexValue: 2, isSelectedScreen: timeProvider.dayIndex == index + 1 ? true : false),
                        titleWidget('${Strings.sunrise}:', timeProvider.prayerTimePojoClass[index].sunrise,
                            indexValue: 3, isSelectedScreen: timeProvider.dayIndex == index + 1 ? true : false),
                        titleWidget('${Strings.dhaur}:', timeProvider.prayerTimePojoClass[index].dhur,
                            indexValue: 4, isSelectedScreen: timeProvider.dayIndex == index + 1 ? true : false),
                        titleWidget('${Strings.asor}:', timeProvider.prayerTimePojoClass[index].asor,
                            indexValue: 5, isSelectedScreen: timeProvider.dayIndex == index + 1 ? true : false),
                        titleWidget('${Strings.magrib}:', timeProvider.prayerTimePojoClass[index].magrib,
                            indexValue: 6, isSelectedScreen: timeProvider.dayIndex == index + 1 ? true : false),
                        titleWidget('${Strings.isha}:', timeProvider.prayerTimePojoClass[index].isha,
                            indexValue: 7, isSelectedScreen: timeProvider.dayIndex == index + 1 ? true : false),
                        Divider(color: timeProvider.dayIndex == index + 1 ? Colors.white : Colors.grey.withOpacity(.4)),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }

  // DataTable buildDataTable(PrayerTimeProvider timeProvider) {
  //   return DataTable(
  //     columnSpacing: 25,
  //     columns: [
  //       DataColumn(label: Text(Strings.date, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //       DataColumn(label: Text(Strings.sehri, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //       DataColumn(label: Text(Strings.fajr, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //       DataColumn(label: Text(Strings.sunrise, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //       DataColumn(label: Text(Strings.dhaur, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //       DataColumn(label: Text(Strings.asor, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //       DataColumn(label: Text(Strings.magrib, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //       DataColumn(label: Text(Strings.isha, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w600))),
  //     ],
  //     rows: timeProvider.prayerTimePojoClass
  //         .map((prayerTime) => DataRow(
  //                 //selected: true,
  //                 color: MaterialStateProperty.all<Color>(timeProvider.dayIndex == prayerTime.selectIndex ? Colors.green : Colors.transparent),
  //                 cells: [
  //                   DataCell(Text('${prayerTime.date}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                   DataCell(Text('${prayerTime.sehri}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                   DataCell(Text('${prayerTime.fajr}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                   DataCell(Text('${prayerTime.sunrise}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                   DataCell(Text('${prayerTime.dhur}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                   DataCell(Text('${prayerTime.asor}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                   DataCell(Text('${prayerTime.magrib}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                   DataCell(Text('${prayerTime.isha}',
  //                       style: poppinsExtraLight.copyWith(color: timeProvider.dayIndex == prayerTime.selectIndex ? Colors.white : Colors.black))),
  //                 ]))
  //         .toList(),
  //   );
  // }
}
