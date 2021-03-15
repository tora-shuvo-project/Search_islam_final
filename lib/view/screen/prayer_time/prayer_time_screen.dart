import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/home/widget/prayer_time_widget.dart';
import 'package:search_islam/view/screen/prayer_time/month_all_prayer_time_screen.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:search_islam/view/widget/custom_button.dart';

class PrayerTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeAllMonthPrayerTimeData();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(title: Strings.namajer_somoysuci, isLocation: true),
          preferredSize: Size(MediaQuery.of(context).size.width, 120),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          children: [
            PrayerTimeWidget(isPrayerTimeScreen: true),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            Consumer<PrayerTimeProvider>(
                builder: (context, timeProvider, child) => Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3) // changes position of shadow
                              )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(Strings.ajker_namajer_somoysuci,
                              style: kalpurus.copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: ColorResources.primaryColor)),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.fajr,
                                      timeStart: timeProvider.fajrTimeStart,
                                      timeEnd: timeProvider.fajrTimeEnd,
                                      index: 1,
                                      prayerTimeProvider: timeProvider)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.dhaur,
                                      timeStart: timeProvider.dhahrTimeStart,
                                      timeEnd: timeProvider.dhahrTimeEnd,
                                      index: 2,
                                      prayerTimeProvider: timeProvider)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.asor,
                                      timeStart: timeProvider.asrTimeStart,
                                      timeEnd: timeProvider.asrTimeEnd,
                                      index: 3,
                                      prayerTimeProvider: timeProvider)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.magrib,
                                      timeStart: timeProvider.magribTimeStart,
                                      timeEnd: timeProvider.magribTimeEnd,
                                      index: 4,
                                      prayerTimeProvider: timeProvider)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.isha,
                                      timeStart: timeProvider.ishaTimeStart,
                                      timeEnd: timeProvider.ishaTimeEnd,
                                      index: 5,
                                      prayerTimeProvider: timeProvider)),
                            ],
                          ),
                          SizedBox(height: 15),
                          _haramTimeWidget(context: context, prayerTimeProvider: timeProvider),
                        ],
                      ),
                    )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            Consumer<PrayerTimeProvider>(
                builder: (context, timeProvider, child) => Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3) // changes position of shadow
                              )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(Strings.agami_kalker_namajer_somoysuci,
                              style: kalpurus.copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: ColorResources.primaryColor)),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.fajr,
                                      timeStart: timeProvider.tommorwFajrTimeStart,
                                      timeEnd: timeProvider.tommorwFajrTimeEnd,
                                      index: 1,
                                      prayerTimeProvider: timeProvider,
                                      isTodayPrayerTime: false)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.dhaur,
                                      timeStart: timeProvider.tommorwDhahrTimeStart,
                                      timeEnd: timeProvider.tommorwDhahrTimeEnd,
                                      index: 2,
                                      prayerTimeProvider: timeProvider,
                                      isTodayPrayerTime: false)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.asor,
                                      timeStart: timeProvider.tommorwAsrTimeStart,
                                      timeEnd: timeProvider.tommorwAsrTimeEnd,
                                      index: 3,
                                      prayerTimeProvider: timeProvider,
                                      isTodayPrayerTime: false)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.magrib,
                                      timeStart: timeProvider.tommorwMagribTimeStart,
                                      timeEnd: timeProvider.tommorwMagribTimeEnd,
                                      index: 4,
                                      prayerTimeProvider: timeProvider,
                                      isTodayPrayerTime: false)),
                              _lineWidget(),
                              Expanded(
                                  child: _timeWidget(
                                      context: context,
                                      title: Strings.isha,
                                      timeStart: timeProvider.tommorwIshaTimeStart,
                                      timeEnd: timeProvider.tommorwIshaTimeEnd,
                                      index: 5,
                                      prayerTimeProvider: timeProvider,
                                      isTodayPrayerTime: false)),
                            ],
                          ),
                          SizedBox(height: 15),
                          _tomorrowIftarSehriWidget(context: context, prayerTimeProvider: timeProvider),
                        ],
                      ),
                    )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            CustomButton(
                buttonText: Strings.puro_maser_namajer_somoy_suci_dekhun,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MonthAllPrayerTimeScreen()));
                })
          ],
        ),
      ),
    );
  }

  Widget _timeWidget(
      {BuildContext context,
      String title,
      String timeStart,
      String timeEnd,
      int index = 0,
      PrayerTimeProvider prayerTimeProvider,
      bool isTodayPrayerTime = true}) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: index == prayerTimeProvider.selectCurrentPrayerCode && isTodayPrayerTime ? Colors.green : Colors.transparent),
            child: Text(title,
                style: kalpurus.copyWith(
                    color: index == prayerTimeProvider.selectCurrentPrayerCode && isTodayPrayerTime ? Colors.white : Colors.black))),
        Text(timeStart, style: poppinsRegular),
        SizedBox(height: 2),
        Text(timeEnd, style: poppinsRegular),
      ],
    );
  }

  Widget _lineWidget() {
    return Container(
        height: 63,
        width: 2,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xffffffff), const Color(0xff178723), const Color(0xffffffff)])));
  }

  Widget _haramTimeWidget({BuildContext context, PrayerTimeProvider prayerTimeProvider, bool isTodayPrayerTime = true}) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
          color: prayerTimeProvider.selectCurrentPrayerCode == -1 && isTodayPrayerTime ? Colors.red : Color(0xFF9F9594),
          borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.salater, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
              Text('${Strings.vor} ${prayerTimeProvider.sunriseTimeStart} - ${prayerTimeProvider.sunriseTimeEnd},',
                  style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w600))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.nisiddo_somoy, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
              Text('${Strings.sondha} ${prayerTimeProvider.asrTimeEnd} - ${prayerTimeProvider.ifTarTime}',
                  style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }

  Widget _tomorrowIftarSehriWidget({BuildContext context, PrayerTimeProvider prayerTimeProvider}) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(color: Color(0xFF9F9594), borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.sehri, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
              Text('${prayerTimeProvider.tommorwSehriTime}',
                  style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w600))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Strings.iftar, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
              Text('${prayerTimeProvider.tommorwIfTarTime}',
                  style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.w600))
            ],
          ),
        ],
      ),
    );
  }
}
