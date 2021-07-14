import 'dart:io';

import 'package:flutter/material.dart';

class ScrollableImageView extends StatelessWidget{
  ScrollableImageView({@required this.imagePath, @required this.viewSize, this.imageSize});

  final File imagePath;
  final Size imageSize;
  final Size viewSize;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: viewSize.height,
      width: viewSize.width,
      child: InteractiveViewer(
        panEnabled: true,
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.5,
        maxScale: 3,
        child: Image.memory(FileImage(imagePath).file.readAsBytesSync()),
      ),
    );
  }
}
