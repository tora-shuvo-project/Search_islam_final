import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/doya/widget/doya_details_bottom_navigation_bar_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:share/share.dart';

class DoyaDetailsScreen extends StatelessWidget {
  final String id;
  final String name;

  DoyaDetailsScreen({this.id, this.name});

  @override
  Widget build(BuildContext context) {
    Provider.of<DoyaProvider>(context, listen: false).initializeDoyaDetails(id);
    

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: name, isBackgroundPrimaryColor: true), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        bottomNavigationBar: DoyaDetailsBottomNavigationBarWidget(name: name),
        body: Consumer<DoyaProvider>(
            builder: (context, doyaProvider, child) => ListView.builder(
                itemCount: doyaProvider.doyaDetailsModels.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Container(
                      color: Colors.green.withOpacity(.030),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: <Widget>[
                          doyaProvider.doyaDetailsModels.length > 1
                              ? Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.green)),
                                  child: Text("${convertEngToBangla(index + 1)}", style: kalpurus.copyWith(fontSize: doyaProvider.fontSize)))
                              : SizedBox.shrink(),
                          doyaProvider.doyaDetailsModels.length > 1
                              ? Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [const Color(0xffffffff), const Color(0xff178723), const Color(0xffffffff)])))
                              : SizedBox.shrink(),
                          doyaProvider.doyaDetailsModels[index].niyom == null
                              ? SizedBox.shrink()
                              : Container(
                                  alignment: Alignment.center,
                                  child: SelectableText('${doyaProvider.doyaDetailsModels[index].niyom}', style: TextStyle(fontSize: 20))),
                          SizedBox(height: 10),
                          Directionality(
                              textDirection: TextDirection.rtl,
                              child: doyaProvider.doyaDetailsModels[index].arabic != null
                                  ? SelectableText('${doyaProvider.doyaDetailsModels[index].arabic}',
                                      style: madina.copyWith(fontSize: doyaProvider.fontSize + 2, color: Colors.black))
                                  : SizedBox.shrink()),
                          SizedBox(height: 15),
                          doyaProvider.doyaDetailsModels[index].banglaMeaning == null
                              ? SizedBox.shrink()
                              : Container(
                                  alignment: Alignment.center,
                                  child: SelectableText('${doyaProvider.doyaDetailsModels[index].banglaMeaning}',
                                      style: kalpurus.copyWith(fontSize: doyaProvider.fontSize,color: Colors.brown))),
                          SizedBox(height: doyaProvider.doyaDetailsModels[index].banglaMeaning == null ? 0 : 15),
                          doyaProvider.doyaDetailsModels[index].banglaTranslator == null
                              ? SizedBox.shrink()
                              : Container(
                                  alignment: Alignment.center,
                                  child: SelectableText('${doyaProvider.doyaDetailsModels[index].banglaTranslator}',
                                      style: kalpurus.copyWith(fontSize: doyaProvider.fontSize))),
                          SizedBox(height: 15),
                          doyaProvider.doyaDetailsModels[index].bottom == null
                              ? SizedBox.shrink()
                              : Container(
                                  alignment: Alignment.center,
                                  child: SelectableText('${doyaProvider.doyaDetailsModels[index].bottom}',
                                      style: kalpurus.copyWith(fontSize: doyaProvider.fontSize))),
                          SizedBox(height: 15),
                          doyaProvider.doyaDetailsModels[index].reference == null
                              ? SizedBox.shrink()
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: SelectableText('${doyaProvider.doyaDetailsModels[index].reference}',
                                      style: kalpurus.copyWith(color: Colors.black54, fontSize: doyaProvider.fontSize - 2)))
                        ],
                      ),
                    ))),
      ),
    );
  }
}
