import 'package:flutter/material.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/styles.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  final Color color1;
  final Color color2;

  CustomButton({this.onTap, @required this.buttonText,this.color1=Colors.green,this.color2=Colors.green});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)) // changes position of shadow
            ],
            gradient: LinearGradient(colors: [color1, color2]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText, textAlign: TextAlign.center, style: poppinsExtraLight.copyWith(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
