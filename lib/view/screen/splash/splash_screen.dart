
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/database_helper.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';

class SplashScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    Provider.of<QuraanShareefProvider>(context, listen: false).accessDatabase(databaseHelper);
    return Scaffold();
  }
}
