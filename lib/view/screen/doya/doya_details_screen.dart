import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:share/share.dart';

class DoyaDetailsScreen extends StatelessWidget {
  final String id;
  final String name;

  DoyaDetailsScreen({this.id, this.name});

  @override
  Widget build(BuildContext context) {
    Provider.of<DoyaProvider>(context, listen: false).initializeDoyaDetails(id);
    print(id);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: name, isBackgroundPrimaryColor: true), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        bottomNavigationBar: Consumer<DoyaProvider>(
          builder: (context, doyaProvider, child) => Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)])),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      doyaProvider.updateFontSize(isIncrement: false);
                    },
                    child: SvgPicture.asset(Images.font_size_large_to_small_svg, width: 25, height: 25, color: Colors.white)),
                InkWell(
                    onTap: () {
                      doyaProvider.updateFontSize();
                    },
                    child: SvgPicture.asset(Images.font_size_small_to_large_svg, width: 25, height: 25, color: Colors.white)),
                InkWell(
                    onTap: () {
                      String message =
                          '${doyaProvider.doyaDetailsModels.first.arabic ?? ''}\n${doyaProvider.doyaDetailsModels.first.banglaTranslator ?? ''}${doyaProvider.doyaDetailsModels.first.banglaMeaning ?? ''}${doyaProvider.doyaDetailsModels.first.reference ?? ''}';

                      Clipboard.setData(ClipboardData(text: message));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(new SnackBar(content: Text(Strings.copy_kora_hoyeche), backgroundColor: Colors.green));
                    },
                    child: Icon(Icons.content_copy, color: Colors.white, size: 25)),
                InkWell(
                    onTap: () {
                      String message =
                          '${doyaProvider.doyaDetailsModels.first.arabic ?? ''}\n${doyaProvider.doyaDetailsModels.first.banglaTranslator ?? ''}${doyaProvider.doyaDetailsModels.first.banglaMeaning ?? ''}${doyaProvider.doyaDetailsModels.first.reference ?? ''}';

                      Share.share(message, subject: '${Strings.ayat_no_english} $name');
                    },
                    child: Icon(Icons.share, color: Colors.white, size: 25)),
              ],
            ),
          ),
        ),
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
