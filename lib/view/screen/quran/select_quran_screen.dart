import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/quran/sura_para_list_screen.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class SelectQuranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: Strings.quran_sharif), preferredSize: Size(MediaQuery.of(context).size.width, 120)),
        body: ListView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [Colors.green, Colors.green.withOpacity(.8), Colors.green]),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3) // changes position of shadow
                      )
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 13),
                      Text(Strings.sorboses_pora_hoyeche, style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Text('${Strings.sura} ', style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                          Text('আর-রহমান',
                              style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text('${Strings.probesh_korun} >>', style: kalpurus.copyWith(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE)),
                    ],
                  ),
                  Positioned(right: 0, bottom: 0, child: SvgPicture.asset(Images.quran_svg, width: 80, height: 80))
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3) // changes position of shadow
                      )
                ],
              ),
              child: Text(
                '${Strings.pocondo_onujaye_jekono}',
                textAlign: TextAlign.center,
                style: kalpurus.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            _itemCategoryWidget(
                title: Strings.sura_krome,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SuraParaListScreen(title: Strings.sura_krome)));
                },
                context: context),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            _itemCategoryWidget(
                title: Strings.para_krome,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => SuraParaListScreen(title: Strings.para_krome, isShowSura: false)));
                },
                context: context),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            _itemCategoryWidget(
                title: Strings.hafeji_quran,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SuraParaListScreen(title: Strings.para_krome, isShowSura: false, isShowHafejiQuranSystem: true)));
                },
                context: context),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            _itemCategoryWidget(title: Strings.quran_sound, onTap: () {}, context: context),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
            _itemCategoryWidget(title: Strings.kayda, onTap: () {}, context: context),
          ],
        ),
      ),
    );
  }

  Widget _itemCategoryWidget({BuildContext context, String title, Function onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            color: Colors.green,
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: kalpurus.copyWith(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 17)),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
