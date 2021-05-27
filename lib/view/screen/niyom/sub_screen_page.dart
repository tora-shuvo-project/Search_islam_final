import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/niyom_models.dart';
import 'package:search_islam/provider/ojifa_provider.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/view/screen/niyom/niyom_details_screen.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class SubScreenScreen extends StatelessWidget {
  final int topicNo;
  final String topicName;

  SubScreenScreen({this.topicNo, this.topicName});

  @override
  Widget build(BuildContext context) {
    Provider.of<OjifaProvider>(context, listen: false).initializeAllNiyoms(topicNo);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: topicName), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: Consumer<OjifaProvider>(
          builder: (context, ojifaProvider, child) => ListView.builder(
              itemCount: ojifaProvider.getAllNiyoms.length,
              padding: EdgeInsets.symmetric(vertical: 10),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => _titleWidget(niyomModel: ojifaProvider.getAllNiyoms[index], context: context)),
        ),
      ),
    );
  }

  Widget _titleWidget({@required NiyomModel niyomModel, @required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(5),
      //margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 3))],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: <Widget>[
          InkWell(
            child: Row(
              children: <Widget>[
                SvgPicture.asset(Images.ojifa_svg, height: 30, width: 30),
                SizedBox(width: 10),
                Expanded(child: Text('${niyomModel.name}', style: TextStyle(color: Colors.black, fontSize: 20, height: 1.8))),
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NiyomDetailsScreen(niyomModel: niyomModel)));
            },
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
