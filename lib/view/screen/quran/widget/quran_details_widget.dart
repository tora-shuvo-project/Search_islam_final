import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/ayat_model.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:share/share.dart';

class QuranDetailsWidget extends StatelessWidget {
  final AyatModel ayatModel;
  final int index;

  QuranDetailsWidget({this.ayatModel, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuraanShareefProvider>(
        builder: (context, quranProvider, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.asset(Images.ayat_number_icon, height: 30, width: 30, fit: BoxFit.cover),
                          Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: Text('${convertEngToBangla(ayatModel.ayatno)}', style: kalpurus.copyWith(color: Colors.black87, fontSize: 13)))
                        ],
                      ),
                      //SizedBox(height: 20,),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: quranProvider.isShowArabic
                                        ? Text(ayatModel.arabicSimple, style: qulammajid.copyWith(fontSize: 22))
                                        : SizedBox.shrink())),
                          ],
                        ),
                        SizedBox(height: quranProvider.isShowBanglaTranslate ? 3 : 0),
                        quranProvider.isShowBanglaTranslate
                            ? Text(ayatModel.banglaTranslator, style: kalpurus.copyWith(fontSize: 18))
                            : SizedBox.shrink(),
                        SizedBox(height: quranProvider.isShowBanglaMeaning ? 3 : 0),
                        quranProvider.isShowBanglaMeaning
                            ? Text(ayatModel.banglaMeaning, style: kalpurus.copyWith(fontSize: 18, color: Colors.black54))
                            : SizedBox.shrink(),
                        SizedBox(height: quranProvider.isShowOther ? 7 : 4),
                        quranProvider.isShowOther
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)]),
                                    borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          quranProvider.playAyatAudio(
                                              context: context, audioUrl: ayatModel.ayatAudio.trim(), index: ayatModel.ayatno);
                                        },
                                        child: Icon(
                                            quranProvider.isPlayAyatAudio && index == quranProvider.playAudioIndex ? Icons.pause : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 20)),
                                    SizedBox(width: 10),
                                    InkWell(
                                        onTap: () {
                                          Clipboard.setData(new ClipboardData(
                                              text:
                                                  '${quranProvider.isShowArabic ? ayatModel.arabicUtmanic : ''}\n${quranProvider.isShowBanglaTranslate ? ayatModel.banglaTranslator : ''}\n${quranProvider.isShowBanglaMeaning ? ayatModel.banglaMeaning : ''}'));

                                          Scaffold.of(context).showSnackBar(new SnackBar(
                                              content: new Text(Strings.copied_to_clipboard, style: poppinsRegular.copyWith(color: Colors.white)),
                                              backgroundColor: Colors.green));
                                        },
                                        child: Icon(Icons.copy, color: Colors.white, size: 20)),
                                    SizedBox(width: 10),
                                    InkWell(
                                        onTap: () {
                                          Share.share(
                                              '${quranProvider.isShowArabic ? ayatModel.arabicUtmanic : ''}\n${quranProvider.isShowBanglaTranslate ? ayatModel.banglaTranslator : ''}\n${quranProvider.isShowBanglaMeaning ? ayatModel.banglaMeaning : ''}',
                                              subject: '${Strings.ayat_no_english} ${ayatModel.ayatno}');
                                        },
                                        child: Icon(Icons.share, color: Colors.white, size: 20))
                                  ],
                                ),
                              )
                            : Container(height: 1, width: MediaQuery.of(context).size.width, color: Colors.grey.withOpacity(.3)),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
