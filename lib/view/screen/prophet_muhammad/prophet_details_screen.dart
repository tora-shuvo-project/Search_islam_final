import 'package:flutter/material.dart';
import 'package:search_islam/data/model/janun_model.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:share/share.dart';

class ProphetDetailsScreen extends StatelessWidget {
  final JanunModel janunModel;

  ProphetDetailsScreen({this.janunModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 6, blurRadius: 10, offset: Offset(0, 3)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.green),
                      padding: EdgeInsets.zero,
                    ),
                    Expanded(
                      child: Text(
                        janunModel.title,
                        style: poppinsMedium.copyWith(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(
                            '${janunModel.title}\n\n${janunModel.description.replaceAll("\\n", "\n")}\n\nDownload Islamic Apps (Search Islam)',
                            subject: '${janunModel.title}');
                      },
                      icon: Icon(Icons.share, color: Colors.green),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  shrinkWrap: true,
                  children: [
                    Text(
                      janunModel.description.replaceAll("\\n", "\n"),
                      style: kalpurus.copyWith(fontSize: 17),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
