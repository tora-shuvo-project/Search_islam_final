import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_islam/utill/styles.dart';

class CategoryWidget extends StatelessWidget {
  final String iconUrl;
  final String title;

  CategoryWidget({this.iconUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1))],
            color: Colors.white),
        height: 110,
        child: InkWell(
          onTap: () {
            //Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoyaSubcategoryScreen(1, 'নিত্যদিন')));
          },
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(iconUrl, height: 40, width: 40),
                SizedBox(height: 10),
                Text(title, style: kalpurus.copyWith(color: Colors.black, fontWeight: FontWeight.w600))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
