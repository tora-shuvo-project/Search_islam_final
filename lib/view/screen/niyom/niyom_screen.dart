import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/view/screen/niyom/sub_screen_page.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class NiyomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: Strings.niyom), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 10),
            _titleWidget(title: Strings.namaj, context: context, categoryNo: 1),
            _titleWidget(title: Strings.namajer_pore_doya_somuh, context: context, categoryNo: 7),
            _titleWidget(title: Strings.oju, context: context, categoryNo: 2),
            _titleWidget(title: Strings.gocol, context: context, categoryNo: 3),
            _titleWidget(title: Strings.tayammum, context: context, categoryNo: 4),
            _titleWidget(title: Strings.azan_ekamat, context: context, categoryNo: 5),
            _titleWidget(title: Strings.mreto_bekty, context: context, categoryNo: 6),
          ],
        ),
      ),
    );
  }

  Widget _titleWidget({@required String title, @required BuildContext context, int categoryNo}) {
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubScreenScreen(topicNo: categoryNo, topicName: title)));
            },
            child: Row(
              children: <Widget>[
                SvgPicture.asset(Images.iman_svg, height: 30, width: 30),
                Expanded(child: Center(child: Text('$title', style: TextStyle(color: Colors.black, fontSize: 20, height: 1.8)))),
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
