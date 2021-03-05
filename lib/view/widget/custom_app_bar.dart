import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/prayer_time/location_set_screen.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool isLocation;
  final bool isBackgroundPrimaryColor;

  CustomAppBar({this.title, this.isLocation = false, this.isBackgroundPrimaryColor = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(isBackgroundPrimaryColor ? 0 : 30)),
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
                  Navigator.of(context).pop();
                }),
            Expanded(child: Text(title, style: poppinsMedium.copyWith(color: Colors.white, fontSize: 18))),
            isLocation
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>LocationSetScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.white),
                        Text('| ${Provider.of<LocationProvider>(context).getDistrictName()}   ',
                            style: poppinsRegular.copyWith(color: Colors.white, fontSize: 17))
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
