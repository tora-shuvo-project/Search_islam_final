import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/provider/theme_provider.dart';
import 'package:search_islam/utill/color_resources.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';

class QuranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8F3F5),
      appBar: AppBar(
          elevation: 0,
          title: Text(
            Strings.quran_sharif,
            style:
                Theme.of(context).textTheme.headline5.copyWith(color: ColorResources.getPrimaryColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Consumer<QuraanShareefProvider>(
            builder: (context, quranSorifProvider, child) => ListView(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Center(
                      child: SvgPicture.asset(Images.quran1_svg, width: 80, height: 80),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.quran_header_top), fit: BoxFit.fill)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.last_read,
                                style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'সূরা আর-রহমান',
                                style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${Strings.ayat_no} ০১',
                                style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                Strings.go_to,
                                style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                              ),
                            ],
                          ),
                          SvgPicture.asset(Images.history_svg, width: 80, height: 80),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(Images.blue_background), fit: BoxFit.fill),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  Images.quran_svg,
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(height: 25),
                                Text(
                                  Strings.quran,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  Strings.go_to,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(Images.blue_light_background), fit: BoxFit.fill),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  Images.quran2_svg,
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(height: 25),
                                Text(
                                  Strings.hafeji_quran,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  Strings.go_to,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.pink_background), fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  Images.quran_svg,
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(height: 25),
                                Text(
                                  Strings.quran_sound,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  Strings.go_to,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.pink2_background), fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  Images.quran_svg,
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(height: 25),
                                Text(
                                  Strings.kayda,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  Strings.go_to,
                                  style: kalpurus.copyWith(color: ColorResources.getBackgroundColor(context)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                )),
      ),
    );
  }
}
