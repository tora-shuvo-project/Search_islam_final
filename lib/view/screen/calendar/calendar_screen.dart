import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/home_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';

class CalendarScreen extends StatelessWidget {

  Widget titleWidget(String key, String value, {double left = 16, double right = 0, double top = 3, double bottom = 0}) {
    return value != null
        ? Container(
      padding: EdgeInsets.only(left: left, top: top, bottom: bottom, right: right),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(key ?? '', style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
          SizedBox(width: 10),
          Expanded(flex: 4, child: Text(value ?? '', style: TextStyle(fontSize: 16, color: Colors.black)))
        ],
      ),
    )
        : SizedBox.shrink();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.calendar)
      ),
      body: Consumer<HomeProvider>(
        builder: (context,homeProvider,child)=>ListView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          physics: BouncingScrollPhysics(),
          children: [
            Text('আজকের তারিখঃ',style: kalpurus.copyWith(fontSize: 17,fontWeight: FontWeight.w600)),
            titleWidget('আরবিঃ', homeProvider.arabyDate),
            titleWidget('বাংলাঃ', homeProvider.banglaDate),
            titleWidget('ইংরেজিঃ', homeProvider.englishDate),
            SizedBox(height: 20),
            Text('আরবি মাসের নাম ও অর্থঃ',style: kalpurus.copyWith(fontSize: 17,fontWeight: FontWeight.w600)),
            titleWidget('1. মুহররম', '-- নিষিদ্ধ'),
            titleWidget('2. সফর', '-- রিক্ত, শূন্য, ভ্রমণ'),
            titleWidget('3. রবিউল আউয়াল', '-- প্রথম বসন্ত'),
            titleWidget('4. রবিউস সানি', '-- দ্বিতীয় বসন্ত'),
            titleWidget('5. জমাদিউল আউয়াল', '-- প্রথম শুকনো ভূমিখণ্ড'),
            titleWidget('6. জমাদিউস সানি', '-- দ্বিতীয় শুকনো ভূমিখণ্ড'),
            titleWidget('7. রজব', '-- শ্রদ্ধা, সম্মান'),
            titleWidget('8. শা\'বান', '-- বিক্ষিপ্ত'),
            titleWidget('9. রমজান', '-- দহন'),
            titleWidget('10. শাওয়াল', '-- উত্থিত'),
            titleWidget('11. জ্বিলকদ', '-- সাময়িক যুদ্ধবিরতির মাস'),
            titleWidget('12. জ্বিলহজ্জ', '-- হজ্জের মাস'),
            SizedBox(height: 20),
            Text('আরবি দিনের নামগুলি হল নিম্নরূপঃ',style: kalpurus.copyWith(fontSize: 17,fontWeight: FontWeight.w600)),
            titleWidget('- শুক্রবার (Friday)', '– ইয়ামুল জু’মা'),
            titleWidget('- শনিবার (Saturday)', '– ইয়ামুছ ছাবত'),
            titleWidget('- রবিবার (Sunday)', '– ইয়ামুল আহাদ'),
            titleWidget('– সোমবার (Monday)', '– ইয়ামুল ইছনাইন'),
            titleWidget('– মঙ্গলবার (Tuesday)', '– ইয়ামুল ছালাছা'),
            titleWidget('– বুধবার (Wednesday)', '– ইয়ামুল আর’বা'),
            titleWidget('– বৃহস্পতিবার (Thursday)', ' – ইয়ামুল খামিছ'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
