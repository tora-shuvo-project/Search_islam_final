import 'package:flutter/material.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogScreen extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.blog)),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _cardTitle(context, urlLink: 'https://www.alkawsar.com/bn/', title: 'মাসিক আল কাওসার', subTitle: 'Type: Bangla (Blog)', slNo: 1),
          _cardTitle(context, urlLink: 'https://waytotawheed.com/', title: 'ওয়ে টু তাওহীদ', subTitle: 'Type: Bangla (Islamic Books)', slNo: 2),
          _cardTitle(context, urlLink: 'https://alquranbd.com/index.php', title: 'আল-কুরআন বিডি', subTitle: 'Type: Bangla (Read Quran)', slNo: 3),
          _cardTitle(context, urlLink: 'http://www.quraanshareef.org/', title: 'কুরআন-শরিফ', subTitle: 'Type: Bangla (Read Quran)', slNo: 4),
          _cardTitle(context, urlLink: 'https://deenilhaq.wordpress.com/', title: 'দীন ইলহক', subTitle: 'Type: Bangla (Blog)', slNo: 5),
          _cardTitle(context, urlLink: 'https://islamqabd.com/', title: 'ইসলাম কা বিডি', subTitle: 'Type: Bangla (Blog & Question)', slNo: 6),
          _cardTitle(context,
              urlLink: 'https://omukderkotha1.blogspot.com/', title: 'অমুক দের কথা', subTitle: 'Type: Bangla (Thesis & Nastik)', slNo: 7),
          _cardTitle(context, urlLink: 'https://www.hadithbd.com/', title: 'হাদীদ বিডি', subTitle: 'Type: Bangla (Hadith)', slNo: 8),
          _cardTitle(context, urlLink: 'https://tablighjammat.wordpress.com/', title: 'তাবলিক জামাত', subTitle: 'Type: Bangla (Tabligh)', slNo: 9),
          _cardTitle(context,
              urlLink: 'https://habibur.com/salat/districts/dhaka/fullyear/', title: 'হাবিবুর', subTitle: 'Type: English (Prayer Time)', slNo: 10),
          _cardTitle(context, urlLink: 'http://freequranmp3.com/', title: 'ফ্রী কুরআন Mp3', subTitle: 'Type: English (Audio)', slNo: 11),
          _cardTitle(context,
              urlLink: 'http://www.houseofquran.com/qsys/quranteacher1.html',
              title: 'হাউস অফ কুরআন',
              subTitle: 'Type: English (Web App Quran)',
              slNo: 12),
          _cardTitle(context,
              urlLink: 'https://tauheed-sunnat.com/quran-audio-mp3', title: 'তাওহীদ সুন্নাত', subTitle: 'Type: English (Audio)', slNo: 13),
          _cardTitle(context, urlLink: 'https://backtojannah.com/', title: 'বাঁকতও জান্নাহ', subTitle: 'Type: English (Blog)', slNo: 14),
          _cardTitle(context, urlLink: 'https://islamqa.info/bn', title: 'ইসলাম কা', subTitle: 'type: Bangla (Question)', slNo: 15),
          _cardTitle(context, urlLink: 'https://www.quraneralo.com/', title: 'কুরআনের আলো', subTitle: 'Type: Bangla (Blog)', slNo: 16),
          _cardTitle(context, urlLink: 'https://amarspondon.wordpress.com/', title: 'আমার স্পন্ধন', subTitle: 'Type: Bangla (Blog)', slNo: 17),
          _cardTitle(context, urlLink: 'https://adnanfaisal.wordpress.com/', title: 'আদনান ফয়সাল', subTitle: 'Type: Bangla (Blog)', slNo: 18),
          _cardTitle(context, urlLink: 'https://quranerkotha.com/', title: 'কুরআনের কথা', subTitle: 'Type: Bangla (Blog)', slNo: 19),
          _cardTitle(context, urlLink: 'http://www.nakbangla.com/', title: 'নাক বাংলা', subTitle: 'Type: Bangla (Noman Ali Khan)', slNo: 20),
          _cardTitle(context, urlLink: 'http://assunnahtrust.com/', title: 'আস সুন্নাহ ট্রাস্ট', subTitle: 'Type: Bangla (Blog)', slNo: 21),
          _cardTitle(context, urlLink: 'https://www.muslimmedia.info/', title: 'মুসলিম মিডিয়া', subTitle: 'Type: Bangla (Blog)', slNo: 22),
          _cardTitle(context, urlLink: 'http://www.truemuslims.net/Bangla.html', title: 'ট্রু মুসলিম', subTitle: 'Type: English (Audio)', slNo: 23),
        ],
      ),
    );
  }

  Widget _cardTitle(BuildContext context, {String urlLink, String title, String subTitle, int slNo}) {
    return Card(
      child: ListTile(
        onTap: () {
          _launchURL('$urlLink');
        },
        leading: Text('$slNo', style: poppinsMedium.copyWith(fontSize: 17)),
        title: Text('$title', style: kalpurus.copyWith(fontSize: 16)),
        subtitle: Text('$subTitle', style: poppinsRegular),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
