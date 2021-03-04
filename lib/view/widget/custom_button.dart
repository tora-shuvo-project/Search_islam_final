import 'package:flutter/material.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/styles.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;

  CustomButton({this.onTap, @required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onTap,
      padding: EdgeInsets.all(0),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient: LinearGradient(colors: [
              ColorResources.primaryColor,
              ColorResources.primaryColor,
              ColorResources.primaryColor,
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: poppinsSemiBold.copyWith(
              fontSize: 16,
              color: Colors.white,
            )),
      ),
    );
  }
}
