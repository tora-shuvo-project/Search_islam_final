
import 'package:get_it/get_it.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> init() async {

  // Repository
  //sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => QuraanShareefProvider());
  sl.registerFactory(() => PrayerTimeProvider());

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
