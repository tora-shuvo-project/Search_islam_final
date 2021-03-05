import 'package:search_islam/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo{
final SharedPreferences sharedPreferences;

LocationRepo({this.sharedPreferences});

// Save Zila Name
  Future<void> saveDistrictFromPreference(String dristricName)async{
    try{
      await sharedPreferences.setString(AppConstants.ZILA_NAME, dristricName);
    }catch(error){
      throw error;
    }
  }

   String getDistrictNameFromPreference(){
    return  sharedPreferences.getString(AppConstants.ZILA_NAME)??'Dhaka';
  }

  // save Lat lng
  Future<void> saveLatitude(double latitude)async{
    try{
      await sharedPreferences.setDouble(AppConstants.LATITUDE, latitude);
    }catch(error){
      throw error;
    }
  }

  Future<void> saveLongitude(double longitude)async{
    try{
      await sharedPreferences.setDouble(AppConstants.LONGITUDE, longitude);
    }catch(error){
      throw error;
    }
  }

  double getLatitude(){
    return  sharedPreferences.getDouble(AppConstants.LATITUDE)??23.7115253;
  }

 double getLongitude(){
    return  sharedPreferences.getDouble(AppConstants.LONGITUDE)??90.4111451;
  }


  List<String> districtNames = [
    " Bagerhat "	,
    " Bandarban "	,
    " Barguna	"	,
    " Barisal	"	,
    " Bhola	"	,
    " Bogra	"	,
    " Brahmanbaria	"	,
    " Chandpur	"	,
    " Chittagong	"	,
    " Chuadanga	"	,
    " Comilla	"	,
    " Cox's Bazar	"	,
    " Dhaka	"	,
    " Dinajpur	"	,
    " Faridpur	"	,
    " Feni	"	,
    " Gaibandha	"	,
    " Gazipur	"	,
    " Gopalganj	"	,
    " Habiganj	"	,
    " Jaipurhat	"	,
    " Jamalpur	"	,
    " Jessore	"	,
    " Jhalakati	"	,
    " Jhenaidah	"	,
    " Khagrachari	"	,
    " Khulna	"	,
    " Kishoreganj	"	,
    " Kurigram	"	,
    " Kushtia	"	,
    " Lakshmipur	"	,
    " Lalmonirhat	"	,
    " Madaripur	"	,
    " Magura	"	,
    " Manikganj	"	,
    " Meherpur	"	,
    " Moulvibazar	"	,
    " Munshiganj	"	,
    " Mymensingh	"	,
    " Naogaon	"	,
    " Narail	"	,
    " Narayanganj	"	,
    " Narsingdi	"	,
    " Natore	"	,
    " Nawabganj	"	,
    " Netrakona	"	,
    " Nilphamari	"	,
    " Noakhali	"	,
    " Pabna	"	,
    " Panchagarh	"	,
    " Parbattya Chattagram	"	,
    " Patuakhali	"	,
    " Pirojpur	"	,
    " Rajbari	"	,
    " Rajshahi	"	,
    " Rangpur	"	,
    " Satkhira	"	,
    " Shariatpur	"	,
    " Sherpur	"	,
    " Sirajganj	"	,
    " Sunamganj	"	,
    " Sylhet "	,
    " Tangail "	,
    " Thakurgaon	"	,
    " Alipur",
    " Alipurduar",
    " Arambagh",
    " Asansol",
    " Baharampur",
    " Baksa Duar",
    " Balurghat",
    " Bankura",
    " Barackpore",
    " Baranagar",
    " Barddhaman",
    " Beldanga",
    " Benapol",
    " Bhadreswar",
    " Bhatpara",
    " Bishnupur",
    " Calcutta",
    " Chandernagore",
    " Chandrakona",
    " Chanduria",
    " Chinsura",
    " Chittaranjan",
    " Contai",
    " Damodar, R.",
    " Darjilling",
    " Diamond Harbour",
    " Dum-Dum",
    " Duragapur",
    " Haora",
    " Ingraj Bazar",
    " Jalpaiguri",
    " Jangipur",
    " Katoya",
    " Kharagpur",
    " Koch Bihar",
    " Kotalpur",
    " Krishnanagar",
    " Lalbagh",
    " Mehinipur",
    " Murshidabad",
    " Nabadwip",
    " Nalhati",
    " Purulliya",
    " Raghunathpur",
    " Ramaghat",
    " Raniganj",
    " Sagar I.",
    " Santipur",
    " Serampore",
    " Siliguri",
    " Tamluk",
    " Tilpara",
    " Arakan Rakhine",
    " Yangon",
  ];
}