import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/view/screen/doya/doya_details_screen.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class BisoyVittikNameScreen extends StatelessWidget {
  final int category;
  final String categoryName;

  BisoyVittikNameScreen({@required this.category, @required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Provider.of<DoyaProvider>(context, listen: false).initializeBisoyVittikDoya(category);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: categoryName, isBackgroundPrimaryColor: true), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
        body: Consumer<DoyaProvider>(
          builder: (context, doyaProvider, child) => ListView.builder(
              itemCount: doyaProvider.bisoyVittikDoya.length,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1))],
                        color: Colors.white),
                    child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DoyaDetailsScreen(id: doyaProvider.bisoyVittikDoya[index].id, name: doyaProvider.bisoyVittikDoya[index].name)));
                        },
                        title: Text('${doyaProvider.bisoyVittikDoya[index].name}'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        leading: CircleAvatar(child: Text('${convertEngToBangla(index + 1)}'))),
                  )),
        ),
      ),
    );
  }
}
