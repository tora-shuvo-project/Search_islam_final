import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/prayer_time/location_set_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isLocation;
  final bool isBackgroundPrimaryColor;
  final bool isAyatScreen;
  final GlobalKey<ScaffoldState> drawerKey;

  CustomAppBar({this.title, this.isLocation = false, this.isBackgroundPrimaryColor = false, this.isAyatScreen = false, this.drawerKey});

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
                  if (isAyatScreen) Provider.of<QuraanShareefProvider>(context, listen: false).dismissAudio();
                  Navigator.of(context).pop();
                }),
            Expanded(child: Text(title, style: poppinsMedium.copyWith(color: Colors.white, fontSize: 18))),
            isLocation
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => LocationSetScreen()));
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
                    : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
