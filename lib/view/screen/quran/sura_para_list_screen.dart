import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/quran/widget/sura_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:search_islam/view/widget/custom_text_field.dart';

class SuraParaListScreen extends StatelessWidget {
  final String title;
  final bool isShowSura;

  SuraParaListScreen({@required this.title, this.isShowSura = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              child: CustomAppBar(title: title, isBackgroundPrimaryColor: true), preferredSize: Size(MediaQuery.of(context).size.width, 120)),
          body: Consumer<QuraanShareefProvider>(
              builder: (context, quranProvider, child) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)])),
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: CustomTextField(
                          hintText: Strings.search,
                          controller: quranProvider.controller,
                          isShowSuffixIcon: true,
                          inputAction: TextInputAction.search,
                          inputType: TextInputType.text,
                          suffixIconUrl: quranProvider.notEmptyText ? Icons.close_outlined : Icons.search,
                          onSuffixTap: () {
                            quranProvider.clearSearchList(isFromSuraScreen: isShowSura ? true : false);
                          },
                          isIcon: true,
                          onChanged: (value) {
                            isShowSura ? quranProvider.searchSura(value) : quranProvider.searchAyat(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)])),
                                padding: EdgeInsets.only(bottom: 10, top: 5),
                                alignment: Alignment.topCenter,
                                child: Text(Strings.bismillahirahmanirRahim,
                                    style: qulammajid.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white))),
                            Container(
                              margin: EdgeInsets.only(top: 60, left: 10, right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                                child: Container(
                                  color: Colors.white,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 20, bottom: 20),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) => SuraWidget(
                                        suraModel: isShowSura ? quranProvider.suraModels[index] : null,
                                        paraModel: isShowSura ? null : quranProvider.paraList[index],
                                        isFromSuraListScreen: isShowSura ? true : false),
                                    itemCount: isShowSura ? quranProvider.suraModels.length : quranProvider.paraList.length,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
    );
  }
}
