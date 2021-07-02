import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/donate/donate_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomeAlertDialog extends StatefulWidget {
  @override
  _CustomeAlertDialogState createState() => _CustomeAlertDialogState();
}

class _CustomeAlertDialogState extends State<CustomeAlertDialog> with SingleTickerProviderStateMixin {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            height: 230,
            decoration: ShapeDecoration(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0), child: Text('আপনি কি অ্যাাপ থেকে বের হতে চাচ্ছেন ?', style: kalpurus.copyWith(fontSize: 17))),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        decoration: BoxDecoration(color: Colors.green.withOpacity(.3), borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                          child: Text('হ্যাঁ', style: kalpurus.copyWith(fontSize: 16)),
                          onPressed: () {
                            exit(0);
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(color: Colors.green.withOpacity(.5), borderRadius: BorderRadius.circular(8)),
                        child: TextButton(
                          child: Text('না', style: kalpurus.copyWith(fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 2),
                        decoration: BoxDecoration(
                            color: Colors.green, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
                        child: TextButton(
                          child: Text('সহযোগিতা করুন', style: kalpurus.copyWith(color: Colors.white, fontSize: 15)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => DonateScreen()));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.green, borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
                        child: TextButton(
                          child: Text('রেটিং দিন', style: kalpurus.copyWith(color: Colors.white, fontSize: 15)),
                          onPressed: () {
                            _launchURL('https://play.google.com/store/apps/developer?id=duetianmehedishuvo');
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
