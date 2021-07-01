import 'package:flutter/foundation.dart';
import 'package:vibrate/vibrate.dart';

class TasbihProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  updateCount() async {
    _count++;
    if (_count % 33 == 0 || _count % 100 == 0) {
      await Vibrate.vibrate();
    }
    notifyListeners();
  }

  resetCount() {
    _count = 0;
    notifyListeners();
  }

  String tasbihTitle = tasbihData[0];

  setTasbihTitle(String value) {
    tasbihTitle = value;
    _count = 0;
    notifyListeners();
  }
}

List<String> tasbihData = [
  'সুবহানাল্লাহ',
  'আলহামদুলিল্লাহ'
      'আল্লাহু আকবার',
  'আল্লাহুম্মা আনতাস-সালাম',
  'লা ইলাহা ইল্লালা',
  'সুবাহানাল্লাহি ওয়া বিহামদিহী',
  'সুবাহানাল্লাহিল আজিম',
  'সুবাহানাকা-লহুম্মা',
  'লা-হাওলা-ওয়ালা-কুয়া-তা-ইল্লাবিল্লাহ',
  'আসতাগফিরুল্লাহ',
  'আসতাগফিরুল্লাহ অয়াতুবু ইলাইক',
  'সল্লালহু আলাইহিওসল্লাম',
  'আল্লহুম্মা বিসমিকা আমুতু অআহ ইয়া',
  'ইয়ারহামুক আল্লাহ',
  'হাসবুন আল্লাহু ওয়া নিয়ামাল অকিল',
  'আল্লাহুম্মা আজিরনি মিনান নার'
];
