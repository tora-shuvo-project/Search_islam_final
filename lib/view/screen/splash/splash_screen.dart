import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/database_helper.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/view/screen/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    Provider.of<QuraanShareefProvider>(context, listen: false).accessDatabase(databaseHelper);
    return Scaffold(
      //backgroundColor: ColorResources.getPrimaryColor(context),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset(
            Images.splash,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) => Container(
              height: 1000,
              decoration: BoxDecoration(
                  gradient: RadialGradient(radius: 1.5, colors: [Colors.yellow, Colors.transparent], stops: [0, _animationController.value])),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: Duration(seconds: 13),
              child: Image.asset(
                Images.app_logo,
                width: 200,
                height: 200,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 10,
            right: 10,
            child: Image.asset(
              Images.splash_text,
              width: 20,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
