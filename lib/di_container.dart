
import 'package:get_it/get_it.dart';
import 'package:search_islam/data/repository/location_repo.dart';
import 'package:search_islam/data/repository/quran_repo.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> init() async {

  // Repository
  sl.registerLazySingleton(() => LocationRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => QuranRepo(sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => QuraanShareefProvider(quraanRepo: sl()));
  sl.registerFactory(() => PrayerTimeProvider(locationRepo: sl()));
  sl.registerFactory(() => HomeProvider());
  sl.registerFactory(() => LocationProvider(locationRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
