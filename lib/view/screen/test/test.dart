import 'dart:math';

import 'package:flutter/material.dart';
import 'package:search_islam/utill/images.dart';

class QiblahCompassWidget extends StatelessWidget {
  final _compassSvg = Image.asset(Images.compass);
  final _needleSvg = Image.asset(
    Images.compass1,
    fit: BoxFit.contain,
    height: 300,
    alignment: Alignment.center,
  );

  @override
  Widget build(BuildContext context) {

  }
}