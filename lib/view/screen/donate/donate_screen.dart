import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/show_custom_snakbar.dart';

class DonateScreen extends StatefulWidget {
  static final route = '/donate';

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  bool isExpanded1 = true;
  bool isExpanded2 = true;
  bool isExpanded3 = true;
  bool isQuestion = false;

  TextStyle contentTextStyle = TextStyle(fontSize: 17);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Container(
            color: Colors.green,
            padding: EdgeInsets.all(8),
            child: Text(
              'সাদাকায়ে জারিয়ার এই কাজে "সার্চ ইসলাম" মোবাইল আপ্লিকেশন এর সাথে থাকুন।',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: isQuestion == false ? Colors.green.withOpacity(.4) : Colors.green,
                      child: MaterialButton(
                        child: Text('অনুদান করুন', style: kalpurus.copyWith(fontSize: 16, color: isQuestion == true ? Colors.white : Colors.black)),
                        onPressed: () {
                          setState(() {
                            isQuestion = false;
                          });
                        },
                      ),
                    ),
                    isQuestion == false
                        ? ClipPath(
                            clipper: TriangleClipper(),
                            child: Container(color: Colors.green, height: 10, width: 20),
                          )
                        : SizedBox(height: 10)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      color: isQuestion == true ? Colors.green.withOpacity(.4) : Colors.green,
                      width: MediaQuery.of(context).size.width,
                      child: MaterialButton(
                        child: Text(
                          'প্রশ্ন ও উত্তর',
                          style: kalpurus.copyWith(fontSize: 16, color: isQuestion == false ? Colors.white : Colors.black),
                        ),
                        onPressed: () {
                          setState(() {
                            isQuestion = true;
                          });
                        },
                      ),
                    ),
                    isQuestion == true
                        ? ClipPath(
                            clipper: TriangleClipper(),
                            child: Container(color: Colors.green, height: 10, width: 20),
                          )
                        : SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          ),
          isQuestion
              ? Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'আস-সালামু আলাইকুম ওয়া রাহতুল্লাহি ওয়া বারকাতুহু,\n'
                          'সমস্ত প্রশংসা একমাত্র আল্লাহ তায়ালার জন্য, দরূদ ও সালাম মহানবী হযরত মুহাম্মাদ (সা.) এর উপর পেশ করছি, অতঃপর -',
                          style: kalpurus.copyWith(fontSize: 17),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded1 = !isExpanded1;
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    '“সার্চ ইসলাম” মোবাইল আপ্লিকেশন সম্পর্কে সংক্ষেপে কিছু কথা আপনাদের উদ্দেশ্য,',
                                    style: kalpurus.copyWith(fontSize: 17, color: Colors.white),
                                  )),
                                  IconButton(
                                    icon: Icon(isExpanded1 ? Icons.arrow_downward : Icons.close, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        isExpanded1 = !isExpanded1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isExpanded1
                              ? SizedBox.shrink()
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.green.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "আলহামদুলিল্লাহ্, “সার্চ ইসলাম”  এই প্রজেক্ট বিগত ২০ ই মে ২০২০ সালের  কার্যক্রম শুরু করেছি এবং এটি সম্পূর্ণ ব্যাক্তি উদ্যোগে পরিচালিত। এই প্রজেক্টের সাথে কোন ধরনের দল, গ্রুপ বা সংগঠনের সম্পৃক্ততা নেই এবং আমরা এগুলি থেকে মুক্ত, আলহামদুলিল্লাহ্ এবং ভবিষ্যতেও যেন মুক্ত থাকতে পারি আল্লাহর কাছে সেই দুয়া করি সব সময়।আপনাদের সহযোগিতা দ্বীনের এই কাজকে আরও ত্বরান্বিত করবে ইন-শা-আল্লাহ।",
                                    style: kalpurus.copyWith(fontSize: 17),
                                  ),
                                )
                        ],
                      ),
                      Divider(),
                      Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded2 = !isExpanded2;
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: Text('আমাদের উদ্দেশ্য', style: kalpurus.copyWith(fontSize: 16, color: Colors.white))),
                                  IconButton(
                                    icon: Icon(isExpanded2 ? Icons.arrow_downward : Icons.close, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        isExpanded2 = !isExpanded2;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isExpanded2
                              ? SizedBox.shrink()
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.green.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    ' আমাদের একমাত্র উদ্দেশ্য বাংলা ভাষী মানুষের কাছে সঠিক ইসলামকে তুলে ধরা এই আপ্লিকেশন মাধ্যমে, যেন সবাই বিশুদ্ধ ভাবে  ইসলামকে জানতে, বুঝতে ও তা গ্রহন করতে পারে।  আর এই কাজের মাধ্যমে আমরা শুধু একমাত্র আল্লাহর সন্তোষটি অর্জন করতে চাই। দুয়া করি তিনি যেন আমাদের এই ক্ষুদ্র প্রচেষ্টাকে কবুল করেন এবং এর উসিলায় সকলকে হেদায়েত দান করেন এবং ফলাফল হিসাবে জান্নাতুল ফিরদাউস দান করেন। আল্লাহ্ আমাদের সকলকে কবুল করুন। আমীন।আমাদের উদ্দেশ্য এই নয় যে আমরা এই প্রজেক্টের মাধ্যমে টাকা আয় করব আর তা দিয়ে নিজেরা বাড়ি, গাড়ি ইত্যাদি তৈরি করব দুনিয়ার সম্পদ, সম্মান অর্জন করব। আমাদের একমাত্র উদ্দেশ্য আল্লাহর দ্বীন প্রচার এবং এর মাধ্যমে আল্লাহর সন্তোষটি অর্জনের প্রচেষ্টা।',
                                    style: kalpurus.copyWith(fontSize: 17),
                                  ),
                                )
                        ],
                      ),
                      Divider(),
                      Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isExpanded3 = !isExpanded3;
                                });
                              },
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text('অন্য অ্যাাপে ডোনেশন চায় না এখানে কেন চায়?',
                                          style: kalpurus.copyWith(fontSize: 17, color: Colors.white))),
                                  IconButton(
                                    icon: Icon(isExpanded3 ? Icons.arrow_downward : Icons.close, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        isExpanded3 = !isExpanded3;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          isExpanded3
                              ? SizedBox.shrink()
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.green.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'মোবাইল আপ্লিকেশন থেকে অর্থ ইনকামের একমাত্র রাস্তা হচ্ছে গুগলের/ফেছবুকের বিজ্ঞাপন দেখানো।অ্যাাপ ডাউনলোড বা ব্যাবহারে করলে ডেভেলপাররা কোন টাকা পায় না একমাত্র বিজ্ঞাপন দেখালেই টাকা পাওয়া যায়।কিন্তু বিজ্ঞাপন দেখানোর মাধ্যমে পর্দার বিধান লঙ্ঘন হওয়ার আশংকায় আমরা উপার্জনের এই একটি মাত্রপথ তা বন্ধ করে দিয়েছি।তাই এই আপ্লিকেশন উত্তরোত্তর আধুনিকায়ন ও মেইনটেনেন্সের জন্য সাহায্য করতে চাইলে অনুদান দিতে পারেন। ',
                                    style: kalpurus.copyWith(fontSize: 17),
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Text('নিচের অপশনগুলোর মাধ্যমে এই অ্যাাপের জন্য প্রতি মাসে আর্থিক অনুদান পাঠাতে পারেন।',
                            style: kalpurus.copyWith(fontSize: 18)),
                      ),
                      //Divider(),
                      ListTile(
                        tileColor: Colors.green.withOpacity(.08),
                        title: Text('Bkash', style: poppinsSemiBold.copyWith(fontSize: 17)),
                        subtitle: Text('Account Number: 01777368276\nAccount Type: Personal', style: poppinsRegular.copyWith(fontSize: 15)),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: () {
                            showCustomSnackBar(Strings.copy_kora_hoyeche, context);
                            Clipboard.setData(ClipboardData(text: '01777368276'));
                          },
                        ),
                      ),
                      Divider(),
                      ListTile(
                        tileColor: Colors.green.withOpacity(.08),
                        title: Text('Rocket', style: poppinsSemiBold.copyWith(fontSize: 17)),
                        subtitle: Text('Account Number: 01777368276-4\nAccount Type: Personal', style: poppinsRegular.copyWith(fontSize: 15)),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: () {
                            showCustomSnackBar(Strings.copy_kora_hoyeche, context);
                            Clipboard.setData(ClipboardData(text: '017773682764'));
                          },
                        ),
                      ),
                      Divider(),
                      ListTile(
                        tileColor: Colors.green.withOpacity(.08),
                        title: Text('Sure Cash', style: poppinsSemiBold.copyWith(fontSize: 17)),
                        subtitle: Text('Account Number: 01777368276\nAccount Type: Personal', style: poppinsRegular.copyWith(fontSize: 15)),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: () {
                            showCustomSnackBar(Strings.copy_kora_hoyeche, context);
                            Clipboard.setData(ClipboardData(text: '01777368276'));
                          },
                        ),
                      ),
                      Divider(),
                      ListTile(
                        tileColor: Colors.green.withOpacity(.08),
                        title: Text('Nexus Pay', style: poppinsSemiBold.copyWith(fontSize: 17)),
                        subtitle: Text(
                            'Account Name: Mehedi Hasan Shuvo'
                            '\nAccount Number: 2551510025146'
                            '\nAccount type: Savings Account',
                            style: poppinsRegular.copyWith(fontSize: 15)),
                        trailing: IconButton(
                          icon: Icon(Icons.content_copy),
                          onPressed: () {
                            showCustomSnackBar(Strings.copy_kora_hoyeche, context);
                            Clipboard.setData(ClipboardData(
                                text: 'Account Name: Mehedi Hasan Shuvo\nAccount Number: 2551510025146\nAccount type: Savings Account'));
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                )
        ],
      )),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
