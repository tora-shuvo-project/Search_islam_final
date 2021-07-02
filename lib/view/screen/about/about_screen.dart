import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/show_custom_snakbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _mailto(String email) async {
    final phoneUrl = 'mailto:$email';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Cannot launch phone call';
    }
  }

  void launchWhatsApp({@required String phone, @required String message}) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  Future<void> _callNumber(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Cannot launch phone call';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('About'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            padding: EdgeInsets.all(36),
            child: Image.asset(Images.app_logo),
          ),
          Center(child: Text('সত্যের সন্ধানে', style: kalpurus.copyWith(fontSize: 18))),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    isDismissible: false,
                    builder: (BuildContext context) {
                      return DraggableScrollableSheet(
                          initialChildSize: 0.75,
                          maxChildSize: 0.75,
                          minChildSize: 0.75,
                          expand: true,
                          builder: (context, scrollController) {
                            return aboutDeveloperWidget();
                          });
                    });
              },
              child: ProfileListItem(icon: Icons.account_box_outlined, text: 'About Developer')),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    isDismissible: false,
                    builder: (BuildContext context) {
                      return DraggableScrollableSheet(
                          initialChildSize: 0.75,
                          maxChildSize: 0.75,
                          minChildSize: 0.75,
                          expand: true,
                          builder: (context, scrollController) {
                            return featuresWidget();
                          });
                    });
              },
              child: ProfileListItem(icon: Icons.feedback, text: 'About Features')),
          InkWell(
              onTap: () {
                showCustomSnackBar('Version No: 02', context);
              },
              child: ProfileListItem(icon: Icons.info, text: 'About Version', hasNavigation: false)),
          InkWell(
              onTap: () {
                _launchURL('https://play.google.com/store/apps/developer?id=duetianmehedishuvo');
              },
              child: ProfileListItem(icon: Icons.star, text: 'Give Rating', hasNavigation: false)),
        ],
      ),
    );
  }

  Container aboutDeveloperWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Developer', style: poppinsSemiBold.copyWith(color: Colors.green, fontSize: 17)),
          ),
          Divider(),
          Column(
            children: [
              Text('Mehedi Hasan Shuvo', style: poppinsMedium.copyWith(fontSize: 15)),
              Text('Software Engineer', style: poppinsRegular),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Text('Contact:', style: poppinsSemiBold.copyWith(color: Colors.green, fontSize: 17)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          _launchURL('https://web.facebook.com/m.mehedihasanshuvo.in/');
                        },
                        child: Image.asset(Images.fb, width: 40, height: 40)),
                    InkWell(
                        onTap: () {
                          _callNumber('01303129515');
                        },
                        child: Image.asset(Images.call, width: 40, height: 40)),
                    InkWell(
                        onTap: () {
                          launchWhatsApp(phone: '01303129515', message: '');
                        },
                        child: Image.asset(Images.whatsapp, width: 40, height: 40)),
                    InkWell(
                        onTap: () {
                          _mailto('duetinmehedishuvo@gmail.com');
                        },
                        child: Image.asset(Images.gmail, width: 40, height: 40)),
                  ],
                ),
                Divider(),
                Text('About:', style: poppinsSemiBold.copyWith(color: Colors.green, fontSize: 17)),
                SizedBox(height: 10),
                Text(
                    'আসসালামুআলাইকুম। আমি মোঃ মেহেদি হাসান শুভ,বরিশাল সরকারী পলিটেকনিক থেকে ডিপ্লোমা ইন ইঞ্জিনিয়ারিং পাশ করে বর্তমানে ঢাকা প্রকৌশল ও প্রযুক্তি বিশ্ববিদ্যালয় এ কম্পিউটার সাইন্স এন্ড ইঞ্জিনিয়ারিং বিভাগে এ অধ্যয়নরত। আমার গ্রামের বাড়ি হচ্ছে কালকিনি,মাদারীপুর। ভাল লাগা থেকেই আমার এই কাজগুলো করা। আসলে অনেক দিন থেকেই এমন একটা জিনিস করার কথা মাথায় ছিল কিন্তু করা হয়ে উঠে নাই,অতঃপর এই করোনা মহামারি মধ্যে সময়টাকে আলহামদুলিল্লাহ পরিপূর্ন ভাবে কাজে লাগাতে পেরেছি। এটা দ্বিতীয়  ভার্শন  প্রথম ভার্শন এর অনেক সমস্যা সল্ভ করা হয়েছে তারপর  কিছু ভুল ভ্রান্তি থাকতেই পারে এর জন্য সকলের কাছে ক্ষমা চাচ্ছি আর ভুলগুলো ধরিয়ে দিতে পারলে অনেক উপকার হত। ভুলগুলো ইমেইল এ পাঠালে ভাল হবে। আমি সংশোধন করার চেষ্টা করব ইং-শা-আল্লাহ। অনেক কিছু এই ইচ্ছা ছিল কিন্তু সব কিছু ইমপ্লিমেন্ট করতে পারি নাই ইং-শা-আল্লাহ খুব তারা তারিই করে ফেলব। সবাই আমার জন্য দোয়া করবেন। যাযাকাল্লাহু খাইর।',
                    style: kalpurus.copyWith(fontSize: 18))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container featuresWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Features', style: poppinsSemiBold.copyWith(color: Colors.green, fontSize: 17)),
          ),
          Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Text('Current Features:', style: poppinsSemiBold.copyWith(color: Colors.green, fontSize: 17)),
                SizedBox(height: 10),
                Text(
                    '1. Read Quran With Audio'
                    '\n2. kayda'
                    '\n3. Prayer Times'
                    '\n4. Quranic Word'
                    '\n5. Ojifa'
                    '\n6. Dua'
                    '\n7. Live Comment'
                    '\n8. Tasbih'
                    '\n9. Kibla'
                    '\n10. Bukhari Sharif'
                    '\n11. Rules and Regulations'
                    '\n12. Islamic Calender'
                    '\n13. Islamic Blog'
                    '\n14. Islamic Resources'
                    '\n15. Prophet Muhammad sal.'
                    '\n16. zakat Calculation'
                    '\n17. nosihat'
                    '\n18. Islamic Names & Meaning'
                    '\n19. Labbayek Allahumma Labbayek Sound'
                    '\n20. 5 Kari audio voice',
                    style: poppinsRegular.copyWith(fontSize: 17)),
                Divider(),
                Text('Upcoming Features:', style: poppinsSemiBold.copyWith(color: Colors.green, fontSize: 17)),
                SizedBox(height: 10),
                Text(
                  '1. Listen & Set Ringtone'
                  '\n2. Live Wallpaper'
                  '\n3. Islamic Video'
                  '\n4. Quotte'
                  '\n5. Islamic Event'
                  '\n6. Prayer Time Wise Notification'
                  '\n7. Islamic Short Question'
                  '\n8. Islamic Book read -online,offline'
                  '\n9. and More',
                  style: poppinsRegular.copyWith(fontSize: 17),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xFFF3F7FB)),
      child: Row(
        children: <Widget>[
          Icon(this.icon, size: 20),
          SizedBox(width: 10),
          Text(this.text, style: poppinsRegular.copyWith(fontWeight: FontWeight.w500)),
          Spacer(),
          if (this.hasNavigation) Icon(Icons.chevron_right_outlined, size: 20),
        ],
      ),
    );
  }
}
