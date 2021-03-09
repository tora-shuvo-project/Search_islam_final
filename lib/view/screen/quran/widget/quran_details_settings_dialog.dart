import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/audio_model.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
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
                    CheckboxListTile(title: Text(Strings.arabi), value: quranProvider.isShowArabic, onChanged: quranProvider.updateArabicStatus),
                    CheckboxListTile(
                        title: Text(Strings.bangla_meaning),
                        value: quranProvider.isShowBanglaMeaning,
                        onChanged: quranProvider.updateBanglaMeaningStatus),
                    CheckboxListTile(
                        title: Text(Strings.bangla_uccaron),
                        value: quranProvider.isShowBanglaTranslate,
                        onChanged: quranProvider.updateBanglaTranslateStatus),
                    CheckboxListTile(title: Text(Strings.other), value: quranProvider.isShowOther, onChanged: quranProvider.updateOtherStatus),
                    Column(
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
                          value: quranProvider.qareModel,
                          onChanged: (qare) {
                            quranProvider.changeQareName(qare);
                          },
                        ),
                      ],
                    )
                  ],
                )),
      ),
    );
  }
}
