import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:search_islam/helper/database_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DatabaseHelper suranamedbHelpers = DatabaseHelper.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(jsonEncode(suranamedbHelpers.getAllSuraFromSuraNameTable()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
