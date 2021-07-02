import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/about/about_screen.dart';
import 'package:search_islam/view/screen/donate/donate_screen.dart';
import 'package:search_islam/view/screen/doya/doya_screen.dart';
import 'package:search_islam/view/screen/home/home_screen.dart';
import 'package:search_islam/view/screen/prophet_muhammad/phophet_screen.dart';
import 'package:search_islam/view/screen/quran/select_quran_screen.dart';
import 'package:search_islam/view/screen/settings/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          color: Colors.green,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.asset(Images.app_logo, width: 70, height: 70),
              ),
              SizedBox(height: 15),
              Text('Search Islam\n(সত্যের সন্ধানে)', style: kalpurus.copyWith(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(Images.home_svg, width: 25),
              ),
              title: Text("হোম", style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 1, color: Colors.green.withOpacity(.4)),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SelectQuranScreen()));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(Images.quran_svg, width: 25),
              ),
              title: Text("কুরআন", style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 1, color: Colors.green.withOpacity(.4)),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProphetScreen()));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(Images.muhammad_svg, width: 25),
              ),
              title: Text(Strings.phophet, style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 1, color: Colors.green.withOpacity(.4)),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DoyaScreen()));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(Images.dua_svg, width: 25),
              ),
              title: Text(Strings.doya, style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 1, color: Colors.green.withOpacity(.4)),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  Images.settings_svg,
                  width: 25,
                ),
              ),
              title: Text("সেটিংস", style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 1, color: Colors.green.withOpacity(.4)),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => DonateScreen()));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(Images.donate_svg, width: 25),
              ),
              title: Text("দান করুন", style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 1, color: Colors.green.withOpacity(.4)),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => AboutScreen()));
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(Images.info_svg, width: 25),
              ),
              title: Text("আমাদের সম্পর্কে জানুন", style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 1, color: Colors.green.withOpacity(.4)),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {
                _launchURL('https://play.google.com/store/apps/developer?id=duetianmehedishuvo');
              },
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(Images.share_svg, width: 25),
              ),
              title: Text("শেয়ার করুণ", style: kalpurus.copyWith(fontSize: 17))),
        ),
        Container(height: 250, color: Colors.green.withOpacity(.4)),
      ],
    );
  }
}
