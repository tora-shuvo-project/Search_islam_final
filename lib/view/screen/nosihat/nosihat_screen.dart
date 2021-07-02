import 'package:flutter/material.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/view/screen/nosihat/nosihat_details_screen.dart';

class NosihatScreen extends StatelessWidget {
  Widget _titleWidget({@required String title, int topicNo, String topicName, @required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 3))],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NosihatDetailsScreen(topicNo: topicNo, title: topicName)));
            },
            child: Center(child: Text('$title', style: TextStyle(color: Colors.black, fontSize: 18, height: 1.8))),
          ),
          SizedBox(height: 5),
          Container(
              height: 3,
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: [const Color(0xffffffff), const Color(0xff178723), const Color(0xffffffff)])))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(Strings.nosihat)),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _titleWidget(title: 'মানবজাতির প্রতি কোরআনের কিছু উপদেশ', context: context,topicNo: 1,topicName: 'মানবজাতির প্রতি কোরআনের কিছু উপদেশ'),
          _titleWidget(title: 'স্বামীর ভালোবাসা অর্জনের উপায়', context: context,topicNo: 2,topicName: 'স্বামীর ভালোবাসা অর্জনের উপায়'),
          _titleWidget(title: 'কিছু নিষিদ্ধ কাজ', context: context,topicNo: 3,topicName: 'কিছু নিষিদ্ধ কাজ'),
          _titleWidget(title: 'নসিহাত -১', context: context,topicNo: 4,topicName: 'নসিহাত -১'),
        ],
      ),
    );
  }
}
