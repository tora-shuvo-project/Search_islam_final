import 'dart:io';
import 'package:flutter/material.dart';
import 'package:search_islam/helper/scrollable_image_view.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class ImageViewScreen extends StatelessWidget {
  final File imageFile;
  final String title;

  ImageViewScreen({this.imageFile, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: title), preferredSize: Size(MediaQuery.of(context).size.width, 100)),
        body:ScrollableImageView(
          imagePath: imageFile,
          viewSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height)
        )
      ),
    );
  }
}
