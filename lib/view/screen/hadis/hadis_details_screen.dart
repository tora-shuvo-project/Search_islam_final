import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/hadis_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:share/share.dart';

class HadisDetailsScreen extends StatelessWidget {
  final List<int> detailsRangeIndex;
  final String title;

  HadisDetailsScreen({this.detailsRangeIndex, this.title});

  @override
  Widget build(BuildContext context) {
    Provider.of<HadisProvider>(context, listen: false).loadHadisDetailsData(context, detailsRangeIndex[0], detailsRangeIndex[1]);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(child: CustomAppBar(title: title), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: Consumer<HadisProvider>(
          builder: (context, hadisProvider, child) => hadisProvider.hadisDetailsModel.length > 0 && hadisProvider.hadisDetailsModel != null
              ? ListView.builder(
                  itemCount: hadisProvider.hadisDetailsModel.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  itemBuilder: (context, index) {
                    return hadisChapterWidget(index, hadisProvider);
                  })
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget hadisChapterWidget(int index, HadisProvider hadisProvider) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.1), spreadRadius: 2, blurRadius: 4, offset: Offset(0, 1))],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('হাদিস নংঃ ${convertEngToBangla(hadisProvider.hadisDetailsModel[index].id)}'),
              Text('Sl No: ${index + 1}'),
              InkWell(
                  onTap: () {
                    Share.share(hadisProvider.hadisDetailsModel[index].content, subject: '$title');
                  },
                  child: Icon(Icons.share, color: Colors.green))
            ],
          ),
          SizedBox(height: 20),
          Text(
            hadisProvider.hadisDetailsModel[index].content,
            style: kalpurus.copyWith(fontSize: 18,color: Colors.black),
          ),
          hadisProvider.hadisDetailsModel[index].footnote != null
              ? Text(
                  hadisProvider.hadisDetailsModel[index].footnote,
                  style: kalpurus.copyWith(fontSize: 18),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
