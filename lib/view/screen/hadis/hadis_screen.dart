import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/hadis_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class HadisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: Strings.bokhare_shorif), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: Consumer<HadisProvider>(
          builder: (context, hadisProvider, child) => ListView.builder(
              itemCount: hadisProvider.hadisChapterList.length,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              itemBuilder: (context, index) {
                RegExp regExp = new RegExp(r'(\d+)');
                Iterable<Match> matches = regExp.allMatches(hadisProvider.hadisChapterList[index].hadisRange);
                List<int> numberList = [];
                for (Match match in matches) {
                  numberList.add(int.parse(match.group(0).toString()));
                }

                return HadisChapterWidget(index, hadisProvider, numberList);
              }),
        ),
      ),
    );
  }

  Widget HadisChapterWidget(int index, HadisProvider hadisProvider, List<int> numberList) {
    return Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.1), spreadRadius: 2,
                        blurRadius: 4, offset: Offset(0, 1))],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    CircleAvatar(child: Text('${index + 1}'), radius: 17),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  hadisProvider.hadisChapterList[index].title,
                                  style: kalpurus.copyWith(fontSize: 18),
                                ),
                              ),
                              CircleAvatar(
                                  child: Text('${numberList[1] - numberList[0]} টি', style: kalpurus.copyWith(fontSize: 12, color: Colors.white)),
                                  radius: 17),
                            ],
                          ),
                          Text(
                            'হাদিসঃ ${convertEngToBangla(numberList[0])} - ${convertEngToBangla(numberList[1])}',
                            style: kalpurus.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
  }
}
