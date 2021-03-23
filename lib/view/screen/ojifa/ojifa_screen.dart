import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/view/screen/ojifa/ojifa_details_screen.dart';
import 'package:search_islam/view/screen/ojifa/sub_screen_page.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class OjifaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: Strings.ojifa_somuh), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10),
            _titleWidget(title: Strings.kalema, context: context, isOpenSubOjifaScreen: true, topicNo: 1, topicName: Strings.kalema),
            _titleWidget(title: Strings.dorud_porar_niyom, context: context, topicNo: 2, subTopicNo: 1, topicName: Strings.dorud_porar_niyom),
            _titleWidget(title: Strings.dorud_ibrahim, context: context, topicNo: 2, subTopicNo: 2, topicName: Strings.dorud_ibrahim),
            _titleWidget(title: Strings.isme_ajom, context: context, topicNo: 4, subTopicNo: 1, topicName: Strings.isme_ajom),
            _titleWidget(title: Strings.asmaye_husna, context: context, topicNo: 5, subTopicNo: 1, topicName: Strings.asmaye_husna),
            _titleWidget(title: Strings.saiyedul_istikhar, context: context, topicNo: 6, subTopicNo: 1, topicName: Strings.saiyedul_istikhar),
            _titleWidget(title: Strings.ayate_shifa, context: context,  topicNo: 7, subTopicNo: 1, topicName: Strings.saiyedul_istikhar),
            _titleWidget(title: Strings.salam_7, context: context,  topicNo: 8, subTopicNo: 1, topicName: Strings.salam_7),
            _titleWidget(title: Strings.al_hasor, context: context,  topicNo: 9, subTopicNo: 1, topicName: Strings.al_hasor),
            _titleWidget(title: Strings.aytul_kurse, context: context,  topicNo: 10, subTopicNo: 1, topicName: Strings.aytul_kurse),
            _titleWidget(title: Strings.doya, context: context,isOpenSubOjifaScreen: true, topicNo: 11, topicName: Strings.doya),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget(
      {@required String title, bool isOpenSubOjifaScreen = false, int topicNo, String topicName, @required BuildContext context, int subTopicNo}) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 3))],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              if (isOpenSubOjifaScreen) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SubScreenScreen(topicNo: topicNo, topicName: topicName)));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OjifaDetailsScreen(topicNo: topicNo, subtopicNo: subTopicNo, topicName: topicName)));
              }
            },
            child: Row(
              children: <Widget>[
                SvgPicture.asset(Images.ojifa_svg, height: 30, width: 30),
                Expanded(
                    child: Center(child: Text('$title', style: TextStyle(color: Colors.black, fontSize: 20, height: 1.8)))),
              ],
            ),
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
}
