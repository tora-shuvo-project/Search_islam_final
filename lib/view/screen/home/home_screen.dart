import 'package:deivao_drawer/deivao_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/comment/comment_question_screen.dart';
import 'package:search_islam/view/screen/doya/doya_screen.dart';
import 'package:search_islam/view/screen/hadis/hadis_screen.dart';
import 'package:search_islam/view/screen/home/widget/category_widget.dart';
import 'package:search_islam/view/screen/home/widget/drawer.dart';
import 'package:search_islam/view/screen/home/widget/prayer_time_widget.dart';
import 'package:search_islam/view/screen/kibla/kibla_screen.dart';
import 'package:search_islam/view/screen/labbayeak/labbayeak_screen.dart';
import 'package:search_islam/view/screen/name/name_list_screen.dart';
import 'package:search_islam/view/screen/niyom/niyom_screen.dart';
import 'package:search_islam/view/screen/ojifa/ojifa_screen.dart';
import 'package:search_islam/view/screen/prayer_time/location_set_screen.dart';
import 'package:search_islam/view/screen/prayer_time/prayer_time_screen.dart';
import 'package:search_islam/view/screen/quran/select_quran_screen.dart';
import 'package:search_islam/view/screen/zakat/zakat_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeCurrentPrayerTime();
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeTommorwPrayerTime();
    Provider.of<PrayerTimeProvider>(context, listen: false).checkDaysInMonth();
    Provider.of<HomeProvider>(context, listen: false).initializeAllDate();
    Provider.of<LocationProvider>(context, listen: false).getAllDistrictName();
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeSuraFromPreference();
    final drawerController = DeivaoDrawerController();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.green, statusBarBrightness: Brightness.dark));

    return DeivaoDrawer(
      controller: drawerController,
      drawer: CustomDrawer(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.menu, color: ColorResources.primaryColor), onPressed: drawerController.toggle),
          title: Text(Strings.apps_name, style: poppinsMedium.copyWith(color: ColorResources.primaryColor, fontSize: 18)),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => LocationSetScreen()));
              },
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on, color: ColorResources.primaryColor),
                  Text('| ${Provider.of<LocationProvider>(context).getDistrictName()}   ',
                      style: poppinsRegular.copyWith(color: ColorResources.primaryColor, fontSize: 17))
                ],
              ),
            )
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          children: [
            // for namajer time
            PrayerTimeWidget(),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg, routeWidget: SelectQuranScreen()),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg, routeWidget: DoyaScreen()),
                CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg, routeWidget: OjifaScreen()),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg,routeWidget: CommentQuestionScreen(),),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.labbayek, iconUrl: Images.ojifa_svg, routeWidget: LabbayeakScreen()),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg, routeWidget: PrayerTimeScreen()),
                CategoryWidget(title: Strings.kibla, iconUrl: Images.online_svg, routeWidget: KiblaScreen()),
                CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg, routeWidget: NiyomScreen()),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(
                  title: Strings.zakat,
                  iconUrl: Images.quran_svg,
                  routeWidget: ZakatScreen(),
                ),
                CategoryWidget(
                  title: Strings.name_somuh,
                  iconUrl: Images.dua_svg,
                  routeWidget: NameListScreen(),
                ),
                CategoryWidget(title: Strings.hadis, iconUrl: Images.document_svg, routeWidget: HadisScreen()),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg),
                CategoryWidget(title: Strings.online, iconUrl: Images.online_svg),
                CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg),
                CategoryWidget(title: Strings.quran_sound, iconUrl: Images.document_svg),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg),
                CategoryWidget(title: Strings.online, iconUrl: Images.online_svg),
                CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg),
                CategoryWidget(title: Strings.quran_sound, iconUrl: Images.document_svg),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg),
                CategoryWidget(title: Strings.online, iconUrl: Images.online_svg),
                CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
