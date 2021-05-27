import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/quran/quran_sound/image_view_screen.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:search_islam/view/widget/download_dialog_widget.dart';

class QuranSoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Provider.of<QuraanShareefProvider>(context, listen: false).changeAvailableFileStatus();

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: Strings.quran_sound, isBackgroundPrimaryColor: true, isQuranSoundScreen: true),
            preferredSize: Size(MediaQuery.of(context).size.width, 100)),
        body: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            ClipPath(
              clipper: CurvedBottomClipper(),
              child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)])), height: 200.0),
            ),
            Consumer<QuraanShareefProvider>(
                builder: (context, quranProvider, child) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                    itemCount: quranProvider.getAllQuranWords.length,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            String dir = (await getExternalStorageDirectory()).path;

                            //quranProvider.changeAvailableFileStatus();
                            if (await File('$dir/quran_word${quranProvider.getAllQuranWords[index].serialNo}.png').exists()) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ImageViewScreen(
                                      imageFile: File(quranProvider.storagePath), title: 'Day-${quranProvider.getAllQuranWords[index].serialNo}')));
                            } else {
                              quranProvider.downloadFile(
                                  url: quranProvider.getAllQuranWords[index].imageUrl,
                                  context: context,
                                  percentFunction: (value) {
                                    if (value == 1) {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Dialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                child: DownloadDialogWidget(title: Strings.imageti));
                                          });
                                    }
                                  },
                                  fileName: 'quran_word${quranProvider.getAllQuranWords[index].serialNo}.png');
                            }
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1))],
                                  gradient: LinearGradient(
                                      colors: [Colors.green.withOpacity(.8), Colors.green.withOpacity(.9), Colors.green.withOpacity(.8)]),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(
                                  'Day-${quranProvider.getAllQuranWords[index].serialNo}',
                                  style: poppinsRegular.copyWith(color: Colors.white, fontSize: 20),
                                ),
                                subtitle: new RichText(
                                  text: new TextSpan(
                                    style: poppinsExtraLight.copyWith(color: Colors.white70),
                                    children: <TextSpan>[
                                      new TextSpan(text: '\nTask ${quranProvider.getAllQuranWords[index].taskNumber}\n\n'),
                                      new TextSpan(
                                          text: '${quranProvider.getAllQuranWords[index].percentComplete} Complete',
                                          style: poppinsSemiBold.copyWith(color: Colors.white, letterSpacing: .8)),
                                    ],
                                  ),
                                ),
                              )),
                        )))
          ],
        ),
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 3 / 5;

    // this is top part of path, rectangle without any rounding
    final filledRectangle = Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(-5, size.height - roundingHeight * 2, size.width + 5, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}
