import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';

class QuranDetailsSettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAllQare();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Consumer<QuraanShareefProvider>(
            builder: (context, quranProvider, child) => Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5)],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          CheckboxListTile(
                              title: Text(Strings.arabi), value: quranProvider.isShowArabic(), onChanged: quranProvider.updateArabicStatus),
                          CheckboxListTile(
                              title: Text(Strings.bangla_meaning),
                              value: quranProvider.isShowBanglaMeaning(),
                              onChanged: quranProvider.updateBanglaMeaningStatus),
                          CheckboxListTile(
                              title: Text(Strings.bangla_uccaron),
                              value: quranProvider.isShowBanglaTranslate(),
                              onChanged: quranProvider.updateBanglaTranslateStatus),
                          CheckboxListTile(title: Text(Strings.other), value: quranProvider.isShowOther, onChanged: quranProvider.updateOtherStatus),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5)],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${Strings.kare_nirbacon_korun}', style: kalpurus.copyWith(fontWeight: FontWeight.w700)),
                          DropdownButton<QareModel>(
                            items: quranProvider.qares.map((qareModel) {
                              return new DropdownMenuItem<QareModel>(
                                value: qareModel,
                                child: new Text(qareModel.banglaName, style: poppinsRegular),
                              );
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
                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5)],
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('${Strings.change_font_size}', style: kalpurus.copyWith(fontWeight: FontWeight.w700))),
                              CircleAvatar(
                                child: Text('${quranProvider.fontSize}', style: kalpurus.copyWith(fontWeight: FontWeight.w700, color: Colors.white)),
                              ),
                            ],
                          ),
                          SliderTheme(
                              data: SliderThemeData(
                                  disabledActiveTrackColor: Colors.blue,
                                  disabledInactiveTrackColor: Colors.black12,
                                  trackHeight: 10,
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                  trackShape: RoundedRectSliderTrackShape()),
                              child: Slider(
                                  autofocus: true,
                                  value: quranProvider.fontSize,
                                  onChanged: quranProvider.changeFontSize,
                                  min: 10,
                                  max: 30,
                                  divisions: 20,
                                  label: '${quranProvider.fontSize}')),
                        ],
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}
