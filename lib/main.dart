import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/provider/theme_provider.dart';
import 'package:search_islam/theme/dark_theme.dart';
import 'package:search_islam/theme/light_theme.dart';
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
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
    return MaterialApp(
      title: 'Search Islam',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      home: SplashScreen(),
    );
  }
}
