import 'package:flutter/material.dart';
import 'package:search_islam/utill/styles.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center, style: poppinsRegular.copyWith(color: Colors.white)),
      backgroundColor: isError ? Colors.red : Colors.green,
      elevation: 6.0,
      margin: EdgeInsets.only(bottom: 70, left: 20, right: 20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40)))));
}
