import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/ojifa_model.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/provider/ojifa_provider.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:share/share.dart';

class DoyaDetailsBottomNavigationBarWidget extends StatelessWidget {
  final String name;
  final bool isFromOjifaScreen;

  DoyaDetailsBottomNavigationBarWidget({@required this.name, this.isFromOjifaScreen = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<DoyaProvider>(
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
                  String message = '';
                  if (isFromOjifaScreen) {
                    OjifaModel ojifaModel = Provider.of<OjifaProvider>(context, listen: false).ojifaModel;
                    message =
                        '${ojifaModel.name ?? ''}\n${ojifaModel.araby ?? ''}\n${ojifaModel.banglaTranslator ?? ''}\n${ojifaModel.banglaMeaning ?? ''}';
                  } else {
                    message =
                        '${doyaProvider.doyaDetailsModels.first.arabic ?? ''}\n${doyaProvider.doyaDetailsModels.first.banglaTranslator ?? ''}${doyaProvider.doyaDetailsModels.first.banglaMeaning ?? ''}${doyaProvider.doyaDetailsModels.first.reference ?? ''}';
                  }

                  Clipboard.setData(ClipboardData(text: message));
                  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text(Strings.copy_kora_hoyeche), backgroundColor: Colors.green));

                  },
                child: Icon(Icons.content_copy, color: Colors.white, size: 25)),
            InkWell(
                onTap: () {
                  String message = '';
                  if (isFromOjifaScreen) {
                    OjifaModel ojifaModel = Provider.of<OjifaProvider>(context, listen: false).ojifaModel;
                    message =
                    '${ojifaModel.name ?? ''}\n${ojifaModel.araby ?? ''}\n${ojifaModel.banglaTranslator ?? ''}\n${ojifaModel.banglaMeaning ?? ''}';
                  } else {
                    message =
                    '${doyaProvider.doyaDetailsModels.first.arabic ?? ''}\n${doyaProvider.doyaDetailsModels.first.banglaTranslator ?? ''}${doyaProvider.doyaDetailsModels.first.banglaMeaning ?? ''}${doyaProvider.doyaDetailsModels.first.reference ?? ''}';
                  }

                  Share.share(message, subject: '${isFromOjifaScreen?'':Strings.ayat_no_english} $name');
                },
                child: Icon(Icons.share, color: Colors.white, size: 25)),
          ],
        ),
      ),
    );
  }
}
