import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/string_resources.dart';

class QuranDetailsSettingsDialog extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Consumer<QuraanShareefProvider>(
            builder: (context, quranProvider, child) => Column(
              children: [
                CheckboxListTile(
                    title: Text(Strings.arabi),
                    value: quranProvider.isShowArabic,
                    onChanged: quranProvider.updateArabicStatus),
                CheckboxListTile(
                    title: Text(Strings.bangla_meaning),
                    value: quranProvider.isShowBanglaMeaning,
                    onChanged: quranProvider.updateBanglaMeaningStatus),
                CheckboxListTile(
                    title: Text(Strings.bangla_uccaron),
                    value: quranProvider.isShowBanglaTranslate,
                    onChanged: quranProvider.updateBanglaTranslateStatus),
                CheckboxListTile(
                    title: Text(Strings.other),
                    value: quranProvider.isShowOther,
                    onChanged: quranProvider.updateOtherStatus),
              ],
            )),
      ),
    );
  }
}
