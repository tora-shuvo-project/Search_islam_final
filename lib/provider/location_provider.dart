import 'package:flutter/foundation.dart';
import 'package:search_islam/data/repository/location_repo.dart';

class LatLng {
  double latitude;
  double longitude;

  LatLng(this.latitude, this.longitude);
}

class LocationProvider with ChangeNotifier {
  final LocationRepo locationRepo;

  LocationProvider({this.locationRepo});

  void _getLatLngWithData(LatLng latLng) {
    print(latLng.latitude);
    print(latLng.longitude);
    locationRepo.saveLatitude(latLng.latitude);
    locationRepo.saveLongitude(latLng.longitude);
    notifyListeners();
  }

  // initialize location
  List<String> allDistrictName = [];
  String initializeDistrict = '';

  getAllDistrictName() async{
    if (allDistrictName.length == 0) {
      allDistrictName = [];
      allDistrictName = locationRepo.districtNames;
    }
    notifyListeners();
  }

  // Save District Name
  saveDistrictName(String name) async {
    return locationRepo.saveDistrictFromPreference(name);
  }

  String getDistrictName() {
    return locationRepo.getDistrictNameFromPreference();
  }

  setDistrictName(String name) async {
    initializeDistrict = name;
    saveDistrictName(name);
    districtCheck(name);
    notifyListeners();
  }

  void districtCheck(String district) {
    if (district.trim() == 'Dhaka') {
      _getLatLngWithData(LatLng(23.7115253, 90.4111451));
    } else if (district.trim() == 'Faridpur') {
      _getLatLngWithData(LatLng(23.6070822, 89.8429406));
    } else if (district.trim() == 'Gazipur') {
      _getLatLngWithData(LatLng(24.0022858, 90.4264283));
    } else if (district.trim() == 'Gopalganj') {
      _getLatLngWithData(LatLng(23.0050857, 89.8266059));
    } else if (district.trim() == 'Jamalpur') {
      _getLatLngWithData(LatLng(24.937533, 89.937775));
    } else if (district.trim() == 'Kishoreganj') {
      _getLatLngWithData(LatLng(24.444937, 90.776575));
    } else if (district.trim() == 'Madaripur') {
      _getLatLngWithData(LatLng(23.164102, 90.1896805));
    } else if (district.trim() == 'Manikganj') {
      _getLatLngWithData(LatLng(23.8644, 90.0047));
    } else if (district.trim() == 'Munshiganj') {
      _getLatLngWithData(LatLng(23.5422, 90.5305));
    } else if (district.trim() == 'Mymensingh') {
      _getLatLngWithData(LatLng(24.7471, 90.4203));
    } else if (district.trim() == 'Narayanganj') {
      _getLatLngWithData(LatLng(23.63366, 90.496482));
    } else if (district.trim() == 'Narsingdi') {
      _getLatLngWithData(LatLng(23.932233, 90.71541));
    } else if (district.trim() == 'Netrokona') {
      _getLatLngWithData(LatLng(24.870955, 90.727887));
    } else if (district.trim() == 'Netrakona') {
      _getLatLngWithData(LatLng(24.870955, 90.727887));
    } else if (district.trim() == 'Rajbari') {
      _getLatLngWithData(LatLng(23.7574305, 89.6444665));
    } else if (district.trim() == 'Shariatpur') {
      _getLatLngWithData(LatLng(23.2423, 90.4348));
    } else if (district.trim() == 'Sherpur') {
      _getLatLngWithData(LatLng(25.0204933, 90.0152966));
    } else if (district.trim() == 'Tangail') {
      _getLatLngWithData(LatLng(24.2513, 89.9167));
    } else if (district.trim() == 'Bogura') {
      _getLatLngWithData(LatLng(24.8465228, 89.377755));
    } else if (district.trim() == 'Bogra') {
      _getLatLngWithData(LatLng(24.8465228, 89.377755));
    } else if (district.trim() == 'Joypurhat') {
      _getLatLngWithData(LatLng(25.0968, 89.0227));
    } else if (district.trim() == 'Jaipurhat') {
      _getLatLngWithData(LatLng(25.0968, 89.0227));
    } else if (district.trim() == 'Naogaon') {
      _getLatLngWithData(LatLng(24.7936, 88.9318));
    } else if (district.trim() == 'Natore') {
      _getLatLngWithData(LatLng(24.420556, 89.000282));
    } else if (district.trim() == 'Nawabganj') {
      _getLatLngWithData(LatLng(24.5965034, 88.2775122));
    } else if (district.trim() == 'Pabna') {
      _getLatLngWithData(LatLng(23.998524, 89.233645));
    } else if (district.trim() == 'Rajshahi') {
      _getLatLngWithData(LatLng(24.3745, 88.6042));
    } else if (district.trim() == 'Sirajgonj') {
      _getLatLngWithData(LatLng(24.4533978, 89.7006815));
    } else if (district.trim() == 'Sirajganj') {
      _getLatLngWithData(LatLng(24.4533978, 89.7006815));
    } else if (district.trim() == 'Dinajpur') {
      _getLatLngWithData(LatLng(25.6217061, 88.6354504));
    } else if (district.trim() == 'Gaibandha') {
      _getLatLngWithData(LatLng(25.328751, 89.528088));
    } else if (district.trim() == 'Kurigram') {
      _getLatLngWithData(LatLng(25.805445, 89.636174));
    } else if (district.trim() == 'Lalmonirhat') {
      _getLatLngWithData(LatLng(25.9923, 89.2847));
    } else if (district.trim() == 'Nilphamari') {
      _getLatLngWithData(LatLng(25.931794, 88.856006));
    } else if (district.trim() == 'Panchagarh') {
      _getLatLngWithData(LatLng(26.3411, 88.5541606));
    } else if (district.trim() == 'Rangpur') {
      _getLatLngWithData(LatLng(25.7558096, 89.244462));
    } else if (district.trim() == 'Thakurgaon') {
      _getLatLngWithData(LatLng(26.0336945, 88.4616834));
    } else if (district.trim() == 'Barguna') {
      _getLatLngWithData(LatLng(22.0953, 90.1121));
    } else if (district.trim() == 'Barishal') {
      _getLatLngWithData(LatLng(22.7010, 90.3535));
    } else if (district.trim() == 'Barisal') {
      _getLatLngWithData(LatLng(22.7010, 90.3535));
    } else if (district.trim() == 'Bhola') {
      _getLatLngWithData(LatLng(22.685923, 90.648179));
    } else if (district.trim() == 'Jhalokati') {
      _getLatLngWithData(LatLng(22.6406, 90.1987));
    } else if (district.trim() == 'Jhalakati') {
      _getLatLngWithData(LatLng(22.6406, 90.1987));
    } else if (district.trim() == 'Patuakhali') {
      _getLatLngWithData(LatLng(22.3596316, 90.3298712));
    } else if (district.trim() == 'Pirojpur') {
      _getLatLngWithData(LatLng(22.5841, 89.9720));
    } else if (district.trim() == 'Bandarban') {
      _getLatLngWithData(LatLng(22.1953275, 92.2183773));
    } else if (district.trim() == 'Brahmanbaria') {
      _getLatLngWithData(LatLng(23.9570904, 91.1119286));
    } else if (district.trim() == 'Chandpur') {
      _getLatLngWithData(LatLng(23.2332585, 90.6712912));
    } else if (district.trim() == 'Chattogram') {
      _getLatLngWithData(LatLng(22.335109, 91.834073));
    } else if (district.trim() == 'Chittagong') {
      _getLatLngWithData(LatLng(22.335109, 91.834073));
    } else if (district.trim() == 'Cumilla') {
      _getLatLngWithData(LatLng(23.4682747, 91.1788135));
    } else if (district.trim() == 'Comilla') {
      _getLatLngWithData(LatLng(23.4682747, 91.1788135));
    } else if (district.trim() == "Cox's Bazar") {
      _getLatLngWithData(LatLng(21.4272, 92.0058));
    } else if (district.trim() == 'Feni') {
      _getLatLngWithData(LatLng(23.0159, 91.3976));
    } else if (district.trim() == 'Khagrachari') {
      _getLatLngWithData(LatLng(23.119285, 91.984663));
    } else if (district.trim() == 'Lakshmipur') {
      _getLatLngWithData(LatLng(22.942477, 90.841184));
    } else if (district.trim() == 'Noakhali') {
      _getLatLngWithData(LatLng(22.869563, 91.099398));
    } else if (district.trim() == 'Rangamati') {
      _getLatLngWithData(LatLng(22.7324, 92.2985));
    } else if (district.trim() == 'Parbattya Chattagram') {
      _getLatLngWithData(LatLng(22.7324, 92.2985));
    } else if (district.trim() == 'Habiganj') {
      _getLatLngWithData(LatLng(24.374945, 91.41553));
    } else if (district.trim() == 'Maulvibazar') {
      _getLatLngWithData(LatLng(24.482934, 91.777417));
    } else if (district.trim() == 'Moulvibazar') {
      _getLatLngWithData(LatLng(24.482934, 91.777417));
    } else if (district.trim() == 'Sunamganj') {
      _getLatLngWithData(LatLng(25.0658042, 91.3950115));
    } else if (district.trim() == 'Sylhet') {
      _getLatLngWithData(LatLng(24.8897956, 91.8697894));
    } else if (district.trim() == 'Bagerhat') {
      _getLatLngWithData(LatLng(22.651568, 89.785938));
    } else if (district.trim() == 'Chuadanga') {
      _getLatLngWithData(LatLng(23.6401961, 88.841841));
    } else if (district.trim() == 'Jashore') {
      _getLatLngWithData(LatLng(23.16643, 89.2081126));
    } else if (district.trim() == 'Jessore') {
      _getLatLngWithData(LatLng(23.16643, 89.2081126));
    } else if (district.trim() == 'Jhenaidah') {
      _getLatLngWithData(LatLng(23.5448176, 89.1539213));
    } else if (district.trim() == 'Khulna') {
      _getLatLngWithData(LatLng(22.815774, 89.568679));
    } else if (district.trim() == 'Kushtia') {
      _getLatLngWithData(LatLng(23.901258, 89.120482));
    } else if (district.trim() == 'Magura') {
      _getLatLngWithData(LatLng(23.487337, 89.419956));
    } else if (district.trim() == 'Meherpur') {
      _getLatLngWithData(LatLng(23.762213, 88.631821));
    } else if (district.trim() == 'Narail') {
      _getLatLngWithData(LatLng(23.172534, 89.512672));
    } else if (district.trim() == 'Satkhira') {
      _getLatLngWithData(LatLng(22.7185, 89.0705));
    } else if (district.trim() == 'Alipur') {
      _getLatLngWithData(LatLng(22.32, 88.24));
    } else if (district.trim() == 'Alipurduar') {
      _getLatLngWithData(LatLng(26.30, 89.35));
    } else if (district.trim() == 'Arambagh') {
      _getLatLngWithData(LatLng(22.53, 87.50));
    } else if (district.trim() == 'Asansol') {
      _getLatLngWithData(LatLng(23.42, 87.01));
    } else if (district.trim() == 'Baharampur') {
      _getLatLngWithData(LatLng(24.06, 88.19));
    } else if (district.trim() == 'Baksa Duar	') {
      _getLatLngWithData(LatLng(26.45, 89.35));
    } else if (district.trim() == 'Balurghat') {
      _getLatLngWithData(LatLng(25.14, 88.47));
    } else if (district.trim() == 'Bankura') {
      _getLatLngWithData(LatLng(23.14, 87.07));
    } else if (district.trim() == 'Barackpore') {
      _getLatLngWithData(LatLng(22.46, 88.24));
    } else if (district.trim() == 'Baranagar') {
      _getLatLngWithData(LatLng(22.38, 88.22));
    } else if (district.trim() == 'Barddhaman') {
      _getLatLngWithData(LatLng(23.16, 87.54));
    } else if (district.trim() == 'Beldanga') {
      _getLatLngWithData(LatLng(23.58, 88.20));
    } else if (district.trim() == 'Benapol') {
      _getLatLngWithData(LatLng(23.04, 88.32));
    } else if (district.trim() == 'Bhadreswar') {
      _getLatLngWithData(LatLng(22.49, 88.20));
    } else if (district.trim() == 'Bhatpara') {
      _getLatLngWithData(LatLng(22.54, 88.25));
    } else if (district.trim() == 'Bishnupur') {
      _getLatLngWithData(LatLng(23.05, 87.23));
    } else if (district.trim() == 'Calcutta') {
      _getLatLngWithData(LatLng(22.34, 88.24));
    } else if (district.trim() == 'Chandernagore') {
      _getLatLngWithData(LatLng(22.52, 88.25));
    } else if (district.trim() == 'Chandrakona') {
      _getLatLngWithData(LatLng(22.44, 87.33));
    } else if (district.trim() == 'Chanduria') {
      _getLatLngWithData(LatLng(22.56, 88.55));
    } else if (district.trim() == 'Chinsura') {
      _getLatLngWithData(LatLng(22.53, 88.27));
    } else if (district.trim() == 'Chittaranjan') {
      _getLatLngWithData(LatLng(23.50, 87.00));
    } else if (district.trim() == 'Contai') {
      _getLatLngWithData(LatLng(21.50, 87.48));
    } else if (district.trim() == 'Damodar, R.	') {
      _getLatLngWithData(LatLng(23.17, 87.35));
    } else if (district.trim() == 'Darjilling') {
      _getLatLngWithData(LatLng(27.03, 88.18));
    } else if (district.trim() == 'Diamond Harbour	') {
      _getLatLngWithData(LatLng(22.11, 88.14));
    } else if (district.trim() == 'Dum-Dum	') {
      _getLatLngWithData(LatLng(22.38, 88.38));
    } else if (district.trim() == 'Duragapur') {
      _getLatLngWithData(LatLng(22.30, 87.20));
    } else if (district.trim() == 'Haora') {
      _getLatLngWithData(LatLng(22.35, 88.23));
    } else if (district.trim() == 'Ingraj Bazar	') {
      _getLatLngWithData(LatLng(25.00, 88.11));
    } else if (district.trim() == 'Jalpaiguri') {
      _getLatLngWithData(LatLng(26.32, 88.46));
    } else if (district.trim() == 'Jangipur') {
      _getLatLngWithData(LatLng(24.28, 88.05));
    } else if (district.trim() == 'Katoya') {
      _getLatLngWithData(LatLng(23.39, 88.11));
    } else if (district.trim() == 'Kharagpur') {
      _getLatLngWithData(LatLng(22.30, 87.20));
    } else if (district.trim() == 'Koch Bihar	') {
      _getLatLngWithData(LatLng(26.20, 89.29));
    } else if (district.trim() == 'Kotalpur') {
      _getLatLngWithData(LatLng(23.01, 87.38));
    } else if (district.trim() == 'Krishnanagar') {
      _getLatLngWithData(LatLng(23.24, 88.33));
    } else if (district.trim() == 'Lalbagh') {
      _getLatLngWithData(LatLng(24.13, 88.19));
    } else if (district.trim() == 'Mehinipur') {
      _getLatLngWithData(LatLng(22.25, 87.21));
    } else if (district.trim() == 'Murshidabad') {
      _getLatLngWithData(LatLng(24.11, 88.19));
    } else if (district.trim() == 'Nabadwip') {
      _getLatLngWithData(LatLng(23.24, 88.23));
    } else if (district.trim() == 'Nalhati') {
      _getLatLngWithData(LatLng(22.54, 88.28));
    } else if (district.trim() == 'Purulliya') {
      _getLatLngWithData(LatLng(23.2, 88.28));
    } else if (district.trim() == 'Raghunathpur') {
      _getLatLngWithData(LatLng(23.32, 86.43));
    } else if (district.trim() == 'Ramaghat') {
      _getLatLngWithData(LatLng(23.11, 88.37));
    } else if (district.trim() == 'Raniganj') {
      _getLatLngWithData(LatLng(25.52, 57.52));
    } else if (district.trim() == 'Sagar I.	') {
      _getLatLngWithData(LatLng(21.4, 88.1));
    } else if (district.trim() == 'Santipur') {
      _getLatLngWithData(LatLng(23.14, 88.29));
    } else if (district.trim() == 'Serampore') {
      _getLatLngWithData(LatLng(22.45, 88.23));
    } else if (district.trim() == 'Siliguri') {
      _getLatLngWithData(LatLng(26.42, 88.25));
    } else if (district.trim() == 'Tamluk') {
      _getLatLngWithData(LatLng(22.18, 87.58));
    } else if (district.trim() == 'Tilpara') {
      _getLatLngWithData(LatLng(23.58, 87.32));
    } else if (district.trim() == 'Arakan Rakhine') {
      _getLatLngWithData(LatLng(20.1041, 93.5813));
    } else if (district.trim() == 'Yangon') {
      _getLatLngWithData(LatLng(16.8409, 96.1735));
    } else {
      print('Default Called');
      _getLatLngWithData(LatLng(23.7115253, 90.4111451));
    }
  }
}
