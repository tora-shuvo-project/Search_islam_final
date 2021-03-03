import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deivao_drawer/deivao_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/home/widget/category_widget.dart';
import 'package:search_islam/view/screen/home/widget/drawer.dart';
import 'package:search_islam/view/screen/home/widget/prayer_time_widget.dart';
import 'package:search_islam/view/screen/prayer_time/prayer_time_screen.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeCurrentPrayerTime();
    Provider.of<HomeProvider>(context, listen: false).initializeAllDate();
    final drawerController = DeivaoDrawerController();
    return DeivaoDrawer(
      controller: drawerController,
      drawer: CustomDrawer(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.menu, color: ColorResources.primaryColor), onPressed: drawerController.toggle),
          title: Text('Search Islam', style: poppinsMedium.copyWith(color: ColorResources.primaryColor, fontSize: 18)),
          actions: [
            Row(
              children: <Widget>[
                Icon(Icons.location_on, color: ColorResources.primaryColor),
                Text('| Dhaka   ', style: poppinsRegular.copyWith(color: ColorResources.primaryColor, fontSize: 17))
              ],
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
                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg),
                CategoryWidget(title: Strings.quran_sound, iconUrl: Images.document_svg),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg,routeWidget: PrayerTimeScreen()),
                CategoryWidget(title: Strings.online, iconUrl: Images.online_svg),
                CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg),
                CategoryWidget(title: Strings.quran_sound, iconUrl: Images.document_svg),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg),
                CategoryWidget(title: Strings.online, iconUrl: Images.online_svg),
                CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg),
                CategoryWidget(title: Strings.quran_sound, iconUrl: Images.document_svg),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg),
                CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg),
                CategoryWidget(title: Strings.online, iconUrl: Images.online_svg),
                CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg),
                CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg),
                CategoryWidget(title: Strings.quran_sound, iconUrl: Images.document_svg),
                CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg),
              ],
            ),
            SizedBox(height: 5),
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