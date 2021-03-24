import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/niyom_models.dart';
import 'package:search_islam/data/model/ojifa_model.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/provider/ojifa_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/doya/widget/doya_details_bottom_navigation_bar_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class NiyomDetailsScreen extends StatelessWidget {
  final NiyomModel niyomModel;

  NiyomDetailsScreen({this.niyomModel});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: niyomModel.name), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        bottomNavigationBar: DoyaDetailsBottomNavigationBarWidget(name: niyomModel.name, isFromOjifaScreen: true),
        body: Consumer<OjifaProvider>(
          builder: (context, ojifaProvider, child) => ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            children: [
              Container(
                  alignment: Alignment.center,
                  child: niyomModel.name == "null"
                      ? SizedBox.shrink()
                      : SelectableText('${niyomModel.name}',
                          style: TextStyle(fontSize: Provider.of<DoyaProvider>(context).fontSize + 6))),
              Container(
                  height: 3,
                  decoration:
                      BoxDecoration(gradient: LinearGradient(colors: [const Color(0xffffffff), const Color(0xff178723), const Color(0xffffffff)]))),


              SizedBox(height: 10),
              niyomModel.description == null
                  ? SizedBox.shrink()
                  : SelectableText('${niyomModel.description }',
                      style: TextStyle(fontSize: Provider.of<DoyaProvider>(context).fontSize, fontWeight: FontWeight.w400)),
              SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}
