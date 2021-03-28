import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/provider/labbayek_provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/ojifa_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/provider/theme_provider.dart';
import 'package:search_islam/provider/zakat_provider.dart';
import 'package:search_islam/view/screen/splash/splash_screen.dart';

import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<QuraanShareefProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PrayerTimeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LocationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DoyaProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OjifaProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LabbayekProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ZakatProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.green, statusBarBrightness: Brightness.dark));
    return MaterialApp(
      title: 'Search Islam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'kalpurus',
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
