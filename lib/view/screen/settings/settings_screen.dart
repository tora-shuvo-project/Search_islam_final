import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/data/model/key_model.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/show_custom_snakbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAllFontStyle();
    //Provider.of<LocationProvider>(context, listen: false).getAllDistrictName();
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAllQare();
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Consumer3<LocationProvider, PrayerTimeProvider, QuraanShareefProvider>(
        builder: (context, locationProvider, prayerTimeProvider, quranProvider, child) => ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          children: [
            // zila Nirbacon
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Strings.zila_nirbacon_korun}',
                    style: kalpurus.copyWith(fontWeight: FontWeight.w700),
                  ),
                  DropdownButton<String>(
                    items: locationProvider.allDistrictName.map((String district) {
                      return new DropdownMenuItem<String>(
                        value: district,
                        child: new Text(district, style: poppinsRegular),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    value: locationProvider.getDistrictName(),
                    onChanged: (value) {
                      showCustomSnackBar('Selected District: $value', context);
                      locationProvider.setDistrictName(value);
                    },
                  ),
                ],
              ),
            ),
            // SizedBox(height: 15),
            // madhab nirbacon korun
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Strings.namajer_jonno_madhab_select_korun}',
                    style: kalpurus.copyWith(fontWeight: FontWeight.w700),
                  ),
                  DropdownButton<String>(
                    items: ['hanafi', 'shafi'].map((String district) {
                      return new DropdownMenuItem<String>(
                        value: district,
                        child: new Text(
                          district,
                          style: poppinsRegular,
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    value: prayerTimeProvider.getMajhabName(),
                    onChanged: (value) {
                      showCustomSnackBar('Selected Madhab: $value', context);
                      prayerTimeProvider.saveMajhabName(value);
                      prayerTimeProvider.initializeCurrentPrayerTime();
                      prayerTimeProvider.initializeAllMonthPrayerTimeData();
                      prayerTimeProvider.initializeTommorwPrayerTime();
                    },
                  ),
                ],
              ),
            ),
            //SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Strings.arabic_font_select_korun}', style: kalpurus.copyWith(fontWeight: FontWeight.w700)),
                  DropdownButton<KeyModel>(
                    items: quranProvider.fontStyles.map((fontStyle) {
                      return new DropdownMenuItem<KeyModel>(value: fontStyle, child: new Text(fontStyle.value, style: poppinsRegular));
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    value: quranProvider.fontStyleKeyModel,
                    onChanged: (fontStyle) {
                      quranProvider.changeFontStyle(fontStyle);
                    },
                  ),
                ],
              ),
            ),

            // qare select korun
            Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.green.shade100, spreadRadius: 1, blurRadius: 5)],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Strings.kare_nirbacon_korun}', style: kalpurus.copyWith(fontWeight: FontWeight.w700)),
                  DropdownButton<QareModel>(
                    items: quranProvider.qares.map((qareModel) {
                      return new DropdownMenuItem<QareModel>(
                          value: qareModel, child: new Text(qareModel.banglaName, style: poppinsRegular));
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    value: quranProvider.qareModel,
                    onChanged: (qare) {
                      quranProvider.changeQareName(qare);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
