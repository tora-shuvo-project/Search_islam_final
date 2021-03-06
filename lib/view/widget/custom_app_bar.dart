import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/labbayek_provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/settings/settings_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isLocation;
  final bool isBackgroundPrimaryColor;
  final bool isAyatScreen;
  final GlobalKey<ScaffoldState> drawerKey;
  final bool isShowHafejiQuran;
  final bool isQuranSoundScreen;
  final bool isLabbayekScreen;
  final bool isZakatScreen;

  CustomAppBar(
      {this.title,
      this.isLocation = false,
      this.isBackgroundPrimaryColor = false,
      this.isAyatScreen = false,
      this.drawerKey,
      this.isShowHafejiQuran = false,
      this.isQuranSoundScreen = false,
      this.isLabbayekScreen = false,
      this.isZakatScreen = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(isBackgroundPrimaryColor ? 0 : 30), bottomRight: Radius.circular(isBackgroundPrimaryColor ? 0 : 30)),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)])),
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  if (isAyatScreen)
                    Provider.of<QuraanShareefProvider>(context, listen: false).dismissAudio();
                  else if (isLabbayekScreen) Provider.of<LabbayekProvider>(context, listen: false).stopAudio();
                  Navigator.of(context).pop();
                }),
            Expanded(child: Text(title, style: poppinsMedium.copyWith(color: Colors.white, fontSize: 15))),
            isLocation
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.white),
                        Text('| ${Provider.of<LocationProvider>(context).getDistrictName()}   ',
                            style: poppinsRegular.copyWith(color: Colors.white, fontSize: 17))
                      ],
                    ),
                  )
                : isAyatScreen
                    ? InkWell(
                        onTap: () {
                          drawerKey.currentState.openEndDrawer();
                        },
                        child: Icon(Icons.settings_ethernet, color: Colors.white, size: 26))
                    : isZakatScreen
                        ? InkWell(
                            onTap: () {
                              openBottomSheet(context);
                            },
                            child: Icon(Icons.info, color: Colors.white, size: 26))
                        : isQuranSoundScreen
                            ? TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Container(
                                            color: Color(0xFF737373),
                                            child: ClipRRect(
                                                clipBehavior: Clip.hardEdge,
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                                                child: Container(
                                                  color: Color(0xFFFFFFFF),
                                                  height: MediaQuery.of(context).size.height * 0.80,
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: const Radius.circular(10), topRight: const Radius.circular(10))),
                                                      child: _shururKotha()),
                                                )));
                                      });
                                },
                                child: Text(Strings.surur_kotha, style: TextStyle(color: Colors.white, fontSize: 17)))
                            : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _shururKotha() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Text(Strings.quran_ke_sohoje_bujar_poddote_title, style: kalpurus.copyWith(fontSize: 17, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Divider(height: 2, thickness: 2, color: Colors.green),
            SizedBox(height: 5),
            Text(Strings.quran_ke_sohoje_bujar_poddote_details, style: kalpurus.copyWith(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(Strings.zakater_hisab_kivabe_korben_title,
                              style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 20),
                        Text(Strings.zakater_hisab_kivabe_korben_details, style: kalpurus.copyWith(fontSize: 18, fontWeight: FontWeight.w400)),
                      ],
                    )));
          });
        });
  }
}
