import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/para_models.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/view/screen/quran/widget/quran_settings_drawer.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class HafejiQuranScreen extends StatelessWidget {
  final ParaModel paraModel;

  HafejiQuranScreen({this.paraModel});

  @override
  Widget build(BuildContext context) {
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAyatByParaId(paraModel.paraNo);
    String allAyat = '';
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    return SafeArea(
      child: Scaffold(
        key: _drawerKey,
        endDrawer: QuranSettingsDrawer(isShowHafejiQuran: true),
        appBar: PreferredSize(
            child: CustomAppBar(title: 'Para No: ${paraModel.paraNo}', isBackgroundPrimaryColor: true,isAyatScreen: true,drawerKey: _drawerKey,),
            preferredSize: Size(MediaQuery.of(context).size.width, 100)),
        body: Consumer<QuraanShareefProvider>(
          builder: (context, quranProvider, child) {
            quranProvider.getAllAyat.forEach((element) {
              allAyat = allAyat + ' ' + element.arabicIndopak;
            });
            return ListView(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              physics: BouncingScrollPhysics(),
              children: [
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(allAyat, style: TextStyle(fontSize: quranProvider.fontSize + 4.00, fontFamily: 'Mukadimah', color: Colors.black)))
              ],
            );
          },
        ),
      ),
    );
  }
}
