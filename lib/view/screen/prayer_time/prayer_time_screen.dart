import 'package:flutter/material.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/view/screen/home/widget/prayer_time_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class PrayerTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Color(0xff178723),
        appBar: PreferredSize(
            child: CustomAppBar(title: 'নামাজের সময়সূচি', isLocation: true),
            preferredSize: Size(MediaQuery.of(context).size.width, 120)),
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          children: [PrayerTimeWidget(isPrayerTimeScreen: true)],
        ),
      ),
    );
  }
}
