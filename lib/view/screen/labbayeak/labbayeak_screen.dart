import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/labbayek_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:search_islam/view/widget/download_dialog_widget.dart';

class LabbayeakScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<LabbayekProvider>(context, listen: false).initializeLabbayek();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Provider.of<LabbayekProvider>(context, listen: false).stopAudio();
          Navigator.of(context).pop();
          return Future.value(true);
        },
        child: Scaffold(
          appBar: PreferredSize(
              child: CustomAppBar(title: Strings.labbayekla_humma_labbayek, isLabbayekScreen: true),
              preferredSize: Size(MediaQuery.of(context).size.width, 70)),
          body: Consumer<LabbayekProvider>(
            builder: (context, labbayekProvider, child) => ListView.builder(
                itemCount: labbayekProvider.labbayeks.length,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        labbayekProvider.changeLabbayekModel(labbayekProvider.labbayeks[index]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1))],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(labbayekProvider.labbayeks[index].name, style: kalpurus.copyWith(fontSize: 15)),
                            Icon(Icons.arrow_forward_ios_sharp, color: Colors.green),
                          ],
                        ),
                      ),
                    )),
          ),
          bottomNavigationBar: Consumer<LabbayekProvider>(
            builder: (context, labbayekProvider, child) => Container(
              height: 55,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${labbayekProvider.labbayekModel.name}', style: kalpurus.copyWith(fontSize: 17, color: Colors.white)),
                  Row(
                    children: [
                      InkWell(
                          onTap: () async {
                            String dir = (await getExternalStorageDirectory()).path;
                            if (await File('$dir/${labbayekProvider.labbayekModel.audioKeyName}.mp3').exists()) {
                              labbayekProvider.downloadFile(
                                  url: labbayekProvider.labbayekModel.audioUrl,
                                  context: context,
                                  fileName: '${labbayekProvider.labbayekModel.audioKeyName}.mp3');
                            } else {
                              labbayekProvider.downloadFile(
                                  url: labbayekProvider.labbayekModel.audioUrl,
                                  context: context,
                                  percentFunction: (value) {
                                    if (value == 1) {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return Dialog(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                                child: DownloadDialogWidget(title: Strings.odioti, isLabbayekscreen: true));
                                          });
                                    }
                                  },
                                  fileName: '${labbayekProvider.labbayekModel.audioKeyName}.mp3');
                            }
                          },
                          child: Icon(labbayekProvider.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: Colors.white)),
                      SizedBox(width: 10),
                      InkWell(
                          onTap: () async {
                            await labbayekProvider.stopAudio();
                          },
                          child: Icon(Icons.stop_circle_outlined, color: Colors.white)),
                      SizedBox(width: 10)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
