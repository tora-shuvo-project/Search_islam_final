import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/provider/prayer_time_provider.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';

class PrayerTimeWidget extends StatelessWidget {
  final bool isPrayerTimeScreen;

  PrayerTimeWidget({this.isPrayerTimeScreen = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    colors: [Color(isPrayerTimeScreen ? 0xffFFFFFF : 0xff178723), Color(isPrayerTimeScreen ? 0xffFFFFFF : 0xff27AB4B)]),
                // image: DecorationImage(
                //   image: AssetImage(Images.background10),
                //   fit: BoxFit.cover,
                // ),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3) // changes position of shadow
                      ),
                ],
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
                                SvgPicture.asset(Images.sunrise_svg,
                                    width: 30, height: 30, color: isPrayerTimeScreen ? ColorResources.primaryColor : Colors.white),
                                Text('  ${Strings.sunrise}',
                                    style: kalpurus.copyWith(
                                        color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 30),
                                Text('   ${Provider.of<PrayerTimeProvider>(context, listen: false).sunriseTimeStart}',
                                    style: poppinsExtraLight.copyWith(
                                        color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(width: 2, height: 58, color: isPrayerTimeScreen ? ColorResources.primaryColor : Colors.white),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(Images.sunset_svg,
                                    width: 30, height: 30, color: isPrayerTimeScreen ? ColorResources.primaryColor : Colors.white),
                                Text('  ${Strings.sunset}',
                                    style: kalpurus.copyWith(
                                        color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                              ],
                            ),
                            Text('${Provider.of<PrayerTimeProvider>(context, listen: false).magribTimeStart}',
                                style: poppinsExtraLight.copyWith(
                                    color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: isPrayerTimeScreen ? ColorResources.primaryColor : Colors.white,
                      margin: EdgeInsets.only(top: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${Strings.today}', style: kalpurus.copyWith(color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: 17)),
                      RotateAnimatedTextKit(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context)=>CalenderScreen()
                            // ));
                          },
                          duration: Duration(milliseconds: 5000),
                          text: homeProvider.allDate(),
                          isRepeatingAnimation: true,
                          textStyle: poppinsMedium.copyWith(fontSize: 17.0, color: isPrayerTimeScreen ? Colors.black : Colors.white),
                          textAlign: TextAlign.center,
                          repeatForever: true
                          // or Alignment.topLeft
                          ),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: isPrayerTimeScreen ? ColorResources.primaryColor : Colors.white,
                      margin: EdgeInsets.only(top: 5, bottom: 10)),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${Strings.current_oyakto}',
                                style:
                                    kalpurus.copyWith(color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                            Text('${Provider.of<PrayerTimeProvider>(context).currentPrayerName}',
                                style:
                                    kalpurus.copyWith(color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                            Text(
                                '${Provider.of<PrayerTimeProvider>(context).currentPrayerTimeStart} থেকে ${Provider.of<PrayerTimeProvider>(context).currentPrayerTimeEnd}',
                                style: poppinsExtraLight.copyWith(
                                    color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '${Provider.of<PrayerTimeProvider>(context, listen: false).currentPrayerName == 'ইশা' ? Strings.isa_tahajjut : Provider.of<PrayerTimeProvider>(context, listen: false).currentPrayerName} ${Strings.oyakto_ses_hote_baki}',
                                textAlign: TextAlign.center,
                                style:
                                    kalpurus.copyWith(color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                            Text(
                                '${Provider.of<PrayerTimeProvider>(context).hours.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).minutes.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).seconds.toString().padLeft(2, '0')}',
                                style: poppinsExtraLight.copyWith(
                                    color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 2,
                      color: isPrayerTimeScreen ? ColorResources.primaryColor : Colors.white,
                      margin: EdgeInsets.only(top: 5, bottom: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${Strings.sehri}',
                          textAlign: TextAlign.center,
                          style: kalpurus.copyWith(color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                      Text('${Provider.of<PrayerTimeProvider>(context).sehriTime}',
                          style: poppinsExtraLight.copyWith(
                              color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${Strings.iftar}',
                          textAlign: TextAlign.center,
                          style: kalpurus.copyWith(color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                      Text('${Provider.of<PrayerTimeProvider>(context).magribTimeStart}',
                          style: poppinsExtraLight.copyWith(
                              color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Center(
                    child: Text(
                        '${Strings.iftar} ${Strings.somay_baki_ace}${Provider.of<PrayerTimeProvider>(context).hours.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).minutes.toString().padLeft(2, '0')}:${Provider.of<PrayerTimeProvider>(context).seconds.toString().padLeft(2, '0')}',
                        style: kalpurus.copyWith(color: isPrayerTimeScreen ? Colors.black : Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                  ),
                ],
              ),
            ));
  }
}
