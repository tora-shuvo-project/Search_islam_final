import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/view/screen/doya/doya_details_screen.dart';
import 'package:search_islam/view/widget/custom_text_field.dart';

class SokolDoyaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DoyaProvider>(
        builder: (context, doyaProvider, child) => Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)])),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: Strings.search,
                          controller: doyaProvider.controller,
                          isShowSuffixIcon: true,
                          inputAction: TextInputAction.search,
                          inputType: TextInputType.text,
                          suffixIconUrl: doyaProvider.notEmptyText ? Icons.close_outlined : Icons.search,
                          onSuffixTap: () {
                            doyaProvider.clearSearchList();
                          },
                          isIcon: true,
                          onChanged: (value) {
                            doyaProvider.searchDoyaByNames(value);
                          },
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: doyaProvider.doyaNameList.length,
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
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
                                            DoyaDetailsScreen(id: doyaProvider.doyaNameList[index].id, name: doyaProvider.doyaNameList[index].name)));
                                  },
                                  title: Text('${doyaProvider.doyaNameList[index].name}'),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  leading: CircleAvatar(child: Text('${convertEngToBangla(index + 1)}'))),
                            )),
                  )
                ],
              ),
            ));
  }
}
