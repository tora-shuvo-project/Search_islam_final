import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/provider/ojifa_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/doya/widget/doya_details_bottom_navigation_bar_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class OjifaDetailsScreen extends StatelessWidget {
  final int topicNo, subtopicNo;
  final String topicName;

  OjifaDetailsScreen({this.topicNo, this.subtopicNo, this.topicName});

  @override
  Widget build(BuildContext context) {
    Provider.of<OjifaProvider>(context, listen: false).initializeOjifaModel(topicNo, subtopicNo);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: topicName), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        bottomNavigationBar: DoyaDetailsBottomNavigationBarWidget(name: topicName, isFromOjifaScreen: true),
        body: Consumer<OjifaProvider>(
          builder: (context, ojifaProvider, child) => ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            children: [
              Container(
                  alignment: Alignment.center,
                  child: ojifaProvider.ojifaModel.name == "null"
                      ? SizedBox.shrink()
                      : SelectableText('${ojifaProvider.ojifaModel.name}',
                          style: TextStyle(fontSize: Provider.of<DoyaProvider>(context).fontSize + 6))),
              Container(
                  height: 3,
                  decoration:
                      BoxDecoration(gradient: LinearGradient(colors: [const Color(0xffffffff), const Color(0xff178723), const Color(0xffffffff)]))),
              SizedBox(height: 10),
              ojifaProvider.ojifaModel.araby == null
                  ? SizedBox.shrink()
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: SelectableText('${ojifaProvider.ojifaModel.araby}',
                          style: madina.copyWith(fontSize: Provider.of<DoyaProvider>(context).fontSize + 2, color: Colors.black))),
              SizedBox(height: 10),
              ojifaProvider.ojifaModel.banglaTranslator == null
                  ? SizedBox.shrink()
                  : SelectableText('${Strings.bangla_uccaron}  ${ojifaProvider.ojifaModel.banglaTranslator}',
                      style: TextStyle(fontSize: Provider.of<DoyaProvider>(context).fontSize, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ojifaProvider.ojifaModel.banglaMeaning == null
                  ? SizedBox.shrink()
                  : SelectableText('${Strings.bangla_ortho} ${ojifaProvider.ojifaModel.banglaMeaning}',
                      style: TextStyle(fontSize: Provider.of<DoyaProvider>(context).fontSize - 2))
            ],
          ),
        ),
      ),
    );
  }
}
