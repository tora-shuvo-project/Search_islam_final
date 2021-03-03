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
import 'package:search_islam/view/screen/home_screen/widget/category_widget.dart';
import 'package:search_islam/view/screen/home_screen/widget/drawer.dart';

class HomeScreen extends StatelessWidget {
  final drawerController = DeivaoDrawerController();

  @override
  Widget build(BuildContext context) {
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeCurrentPrayerTime();
    Provider.of<HomeProvider>(context, listen: false).initializeAllDate();
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
            Consumer<HomeProvider>(
                builder: (context, homeProvider, child) => Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)]),
                        image: DecorationImage(
                          image: AssetImage(Images.background10),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(Images.sunrise_svg, width: 30, height: 30, color: Colors.white),
                                        Text('  ${Strings.sunrise}',
                                            style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 30),
                                        Text('   ${Provider.of<PrayerTimeProvider>(context, listen: false).sunriseTimeStart}',
                                            style: poppinsExtraLight.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(width: 2, height: 58, color: Colors.white),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(Images.sunset_svg, width: 30, height: 30, color: Colors.white),
                                        Text('  ${Strings.sunset}',
                                            style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                      ],
                                    ),
                                    Text('${Provider.of<PrayerTimeProvider>(context, listen: false).magribTimeStart}',
                                        style: poppinsExtraLight.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(width: MediaQuery.of(context).size.width, height: 2, color: Colors.white, margin: EdgeInsets.only(top: 5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${Strings.today}', style: kalpurus.copyWith(color: Colors.white, fontSize: 17)),
                              RotateAnimatedTextKit(
                                  onTap: () {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context)=>CalenderScreen()
                                    // ));
                                  },
                                  duration: Duration(milliseconds: 5000),
                                  text: homeProvider.allDate(),
                                  isRepeatingAnimation: true,
                                  textStyle: poppinsMedium.copyWith(fontSize: 17.0, color: Colors.white),
                                  textAlign: TextAlign.center,
                                  repeatForever: true
                                  // or Alignment.topLeft
                                  ),
                            ],
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width, height: 2, color: Colors.white, margin: EdgeInsets.only(top: 5, bottom: 10)),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${Strings.current_oyakto}',
                                        style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                    Text('${Provider.of<PrayerTimeProvider>(context).currentPrayerName}',
                                        style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                    Text('${Provider.of<PrayerTimeProvider>(context).currentPrayerTimeStart}',
                                        style: poppinsExtraLight.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${Provider.of<PrayerTimeProvider>(context, listen: false).currentPrayerName} ${Strings.oyakto_ses_hote_baki}',
                                        textAlign: TextAlign.center,
                                        style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                    Text(
                                        '${Provider.of<PrayerTimeProvider>(context).hours.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).minutes.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).seconds.toString().padLeft(2, '0')}',
                                        style: poppinsExtraLight.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width, height: 2, color: Colors.white, margin: EdgeInsets.only(top: 5, bottom: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${Strings.sehri}',
                                  textAlign: TextAlign.center, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                              Text('${Provider.of<PrayerTimeProvider>(context).sehriTime}',
                                  style: poppinsExtraLight.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${Strings.iftar}',
                                  textAlign: TextAlign.center, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                              Text('${Provider.of<PrayerTimeProvider>(context).magribTimeStart}',
                                  style: poppinsExtraLight.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Center(
                            child: Text(
                                '${Strings.iftar} ${Strings.somay_baki_ace}${Provider.of<PrayerTimeProvider>(context).hours.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).minutes.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).seconds.toString().padLeft(2, '0')}',
                                style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ),
                        ],
                      ),
                    )),
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
