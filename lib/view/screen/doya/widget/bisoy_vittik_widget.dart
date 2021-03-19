import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/doya/widget/category_widget.dart';

class BisoyVittikWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<DoyaProvider>(context, listen: false).initializeAnimationText();
    return Consumer<DoyaProvider>(
        builder: (context, doyaProvider, child) => SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      alignment: Alignment.center,
                      child: RotateAnimatedTextKit(
                        duration: Duration(milliseconds: 6000),
                        text: doyaProvider.allAnimationText,
                        isRepeatingAnimation: true,
                        textStyle: poppinsMedium.copyWith(fontSize: 17.0, color: Colors.black),
                        textAlign: TextAlign.start,
                        // or Alignment.topLeft
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.daily_svg, title: Strings.nittodin, category: 1, categoryName: Strings.nittodin),
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.zikir_svg, title: Strings.zikir_and_gum, category: 2, categoryName: Strings.zikir_and_gum),
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.social_svg, title: Strings.samajik, category: 3, categoryName: Strings.samajik),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.kabba_svg, title: Strings.hoz_siyam, category: 4, categoryName: Strings.hoz_siyam),
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.quran_svg, title: Strings.quran, category: 5, categoryName: Strings.quran),
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.salat_svg, title: Strings.salat, category: 6, categoryName: Strings.salat),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.fellings_svg, title: Strings.onuvuty, category: 7, categoryName: Strings.onuvuty),
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.iman_svg, title: Strings.iman_surokkha, category: 8, categoryName: Strings.iman_surokkha),
                        SizedBox(width: 5),
                        CategoryWidget(iconUrl: Images.ill_svg, title: Strings.osustota, category: 9, categoryName: Strings.osustota),
                        SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
