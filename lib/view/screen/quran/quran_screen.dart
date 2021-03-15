import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';

class QuranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8F3F5),
      appBar: AppBar(
          elevation: 0,

          centerTitle: true,
          backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Consumer<QuraanShareefProvider>(
            builder: (context, quranSorifProvider, child) => ListView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    SizedBox(height: 30),
                  ],
                )),
      ),
    );
  }
}
