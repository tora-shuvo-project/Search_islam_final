import 'package:animated_text_kit/animated_text_kit.dart';
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
import 'package:search_islam/view/screen/about/about_screen.dart';
import 'package:search_islam/view/screen/blog/blog_screen.dart';
import 'package:search_islam/view/screen/calendar/calendar_screen.dart';
import 'package:search_islam/view/screen/comment/comment_question_screen.dart';
import 'package:search_islam/view/screen/donate/donate_screen.dart';
import 'package:search_islam/view/screen/doya/doya_screen.dart';
import 'package:search_islam/view/screen/hadis/hadis_screen.dart';
import 'package:search_islam/view/screen/home/widget/category_widget.dart';
import 'package:search_islam/view/screen/home/widget/drawer.dart';
import 'package:search_islam/view/screen/home/widget/prayer_time_widget.dart';
import 'package:search_islam/view/screen/islamic_resource/islamic_resource_screen.dart';
import 'package:search_islam/view/screen/kibla/kibla_screen.dart';
import 'package:search_islam/view/screen/labbayeak/labbayeak_screen.dart';
import 'package:search_islam/view/screen/name/name_list_screen.dart';
import 'package:search_islam/view/screen/niyom/niyom_screen.dart';
import 'package:search_islam/view/screen/nosihat/nosihat_screen.dart';
import 'package:search_islam/view/screen/ojifa/ojifa_screen.dart';
import 'package:search_islam/view/screen/prayer_time/prayer_time_screen.dart';
import 'package:search_islam/view/screen/prophet_muhammad/phophet_screen.dart';
import 'package:search_islam/view/screen/quran/select_quran_screen.dart';
import 'package:search_islam/view/screen/tasbih/tasbih_screen.dart';
import 'package:search_islam/view/screen/zakat/zakat_screen.dart';
import 'package:search_islam/view/widget/custome_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeCurrentPrayerTime();
    Provider.of<PrayerTimeProvider>(context, listen: false).initializeTommorwPrayerTime();
    Provider.of<PrayerTimeProvider>(context, listen: false).checkDaysInMonth();
    Provider.of<HomeProvider>(context, listen: false).initializeAllDate();
    Provider.of<LocationProvider>(context, listen: false).getAllDistrictName();
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAllQare();
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeSuraFromPreference();
    final drawerController = DeivaoDrawerController();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.green, statusBarBrightness: Brightness.dark));

    return DeivaoDrawer(
      controller: drawerController,
      drawer: CustomDrawer(),
      child: WillPopScope(
        onWillPop: () {
          showDialog(context: context, builder: (_) => CustomeAlertDialog());
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 5,
            backgroundColor: Colors.white,
            leading: IconButton(icon: Icon(Icons.menu, color: ColorResources.primaryColor), onPressed: drawerController.toggle),
            title: Text(Strings.apps_name, style: poppinsMedium.copyWith(color: ColorResources.primaryColor, fontSize: 18)),
            actions: [
              // IconButton(onPressed: () {
              //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsScreen()));
              // }, icon: Icon(Icons.settings, color: Colors.green))
              // Container(
              //   alignment: Alignment.centerRight,
              //   width: 152,
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsScreen()));
              //
              //     },
              //     child: Flexible(
              //       child: Row(
              //         //mainAxisAlignment: MainAxisAlignment.end,
              //         //crossAxisAlignment: CrossAxisAlignment.end,
              //         mainAxisSize: MainAxisSize.min,
              //         children: <Widget>[
              //           Icon(Icons.location_on, color: ColorResources.primaryColor),
              //           Expanded(
              //             child: Text('| ${Provider.of<LocationProvider>(context).getDistrictName()}   ',
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 softWrap: false,
              //                 style: poppinsRegular.copyWith(color: ColorResources.primaryColor, fontSize: 17)),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            children: [
              // for namajer time
              PrayerTimeWidget(),
              SizedBox(height: 15),
              Consumer<HomeProvider>(
                builder: (context, homeProvider, child) => Container(
                  height: 30,
                  alignment: Alignment.center,
                  // ignore: deprecated_member_use
                  child: ScaleAnimatedTextKit(
                    duration: Duration(seconds: 10),
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    text: homeProvider.allDate(),
                    textStyle: kalpurus.copyWith(color: Colors.green, fontSize: 17),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryWidget(title: Strings.quran_sharif, iconUrl: Images.quran_svg, routeWidget: SelectQuranScreen()),
                  CategoryWidget(title: Strings.doya, iconUrl: Images.dua_svg, routeWidget: DoyaScreen()),
                  CategoryWidget(title: Strings.ojifa, iconUrl: Images.ojifa_svg, routeWidget: OjifaScreen()),
                  CategoryWidget(title: Strings.questions, iconUrl: Images.question_svg, routeWidget: CommentQuestionScreen()),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryWidget(title: Strings.labbayek, iconUrl: Images.labbayek_svg, routeWidget: LabbayeakScreen()),
                  CategoryWidget(title: Strings.prayer_time, iconUrl: Images.prayer_time_svg, routeWidget: PrayerTimeScreen()),
                  CategoryWidget(title: Strings.kibla, iconUrl: Images.kabba_svg, routeWidget: KiblaScreen()),
                  CategoryWidget(title: Strings.niyom, iconUrl: Images.method_svg, routeWidget: NiyomScreen()),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryWidget(title: Strings.zakat, iconUrl: Images.zakat_svg, routeWidget: ZakatScreen()),
                  CategoryWidget(title: Strings.name_somuh, iconUrl: Images.names_svg, routeWidget: NameListScreen()),
                  CategoryWidget(title: Strings.bokhare_shorif, iconUrl: Images.document_svg, routeWidget: HadisScreen()),
                  CategoryWidget(title: Strings.phophet, iconUrl: Images.muhammad_svg, routeWidget: ProphetScreen()),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryWidget(title: Strings.islamic_resource, iconUrl: Images.islamic_resources_svg, routeWidget: IslamicResourceScreen()),
                  CategoryWidget(title: Strings.tasbih, iconUrl: Images.tasbih_svg, routeWidget: TasbihScreen()),
                  CategoryWidget(title: Strings.calendar, iconUrl: Images.calendar_svg, routeWidget: CalendarScreen()),
                  CategoryWidget(title: Strings.blog, iconUrl: Images.blog_svg, routeWidget: BlogScreen()),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryWidget(title: Strings.nosihat, iconUrl: Images.knowledge_svg, routeWidget: NosihatScreen()),
                  CategoryWidget(title: Strings.dan_korun, iconUrl: Images.donate_svg, routeWidget: DonateScreen()),
                  CategoryWidget(title: Strings.janun, iconUrl: Images.info_svg, routeWidget: AboutScreen()),
                  CategoryWidget(title: Strings.off_korun, iconUrl: Images.close_svg, isOpenDialog: true),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
