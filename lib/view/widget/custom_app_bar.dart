import 'package:flutter/material.dart';
import 'package:search_islam/utill/styles.dart';

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
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.white),
                        Text('| Dhaka   ', style: poppinsRegular.copyWith(color: Colors.white, fontSize: 17))
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
