import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class PdfViewScreen extends StatelessWidget {
  final String path;
  final String title;

  PdfViewScreen({this.path, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
      appBar: PreferredSize(
          child: SafeArea(
              child: CustomAppBar(
            title: title,
            isBackgroundPrimaryColor: true,
          )),
          preferredSize: Size(MediaQuery.of(context).size.width, 60)),
    );
  }
}
