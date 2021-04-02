import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/name_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_text_field.dart';

class NamesDetailsScreen extends StatelessWidget {
  final String title;
  final String categoryID;

  NamesDetailsScreen({@required this.title, @required this.categoryID});

  @override
  Widget build(BuildContext context) {
    Provider.of<NameProvider>(context, listen: false).initializeData(int.parse(categoryID));
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Consumer<NameProvider>(
        builder: (context, nameProvider, child) => nameProvider.getAllNameList != null || nameProvider.getAllNameList.length < 0
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    child: CustomTextField(
                      hintText: Strings.search,
                      controller: nameProvider.controller,
                      isShowSuffixIcon: true,
                      inputAction: TextInputAction.search,
                      inputType: TextInputType.text,
                      suffixIconUrl: nameProvider.notEmptyText ? Icons.close_outlined : Icons.search,
                      onSuffixTap: () {
                        nameProvider.clearSearchList();
                      },
                      isIcon: true,
                      onChanged: (value) {
                        nameProvider.searchName(value);
                      },
                    ),
                  ),
                  nameProvider.getAllNameList != null || nameProvider.getAllNameList.length > 0
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: nameProvider.getAllNameList.length,
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => Card(
                                    child: ListTile(
                                      title: Text('নামঃ ${nameProvider.getAllNameList[index].title}', style: kalpurus.copyWith(fontSize: 17)),
                                      subtitle: nameProvider.getAllNameList[index].meaning.length > 0
                                          ? Text('${categoryID == '8' ? 'ডাকনামঃ' : 'অর্থঃ'} ${nameProvider.getAllNameList[index].meaning}',
                                              style: kalpurus.copyWith(fontSize: 16))
                                          : SizedBox.shrink(),
                                      leading: CircleAvatar(
                                        radius: 17,
                                        child: Text('${index + 1}', style: kalpurus.copyWith(fontSize: 16, color: Colors.white)),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.copy),
                                        onPressed: () {
                                          Clipboard.setData(new ClipboardData(
                                              text:
                                                  'নামঃ ${nameProvider.getAllNameList[index].title}\n${nameProvider.getAllNameList[index].meaning.length > 0 ? '${categoryID == '8' ? 'ডাকনামঃ' : 'অর্থঃ'} ${nameProvider.getAllNameList[index].meaning}' : ''}'));

                                          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                                              content: new Text(Strings.copied_to_clipboard, style: poppinsRegular.copyWith(color: Colors.white)),
                                              backgroundColor: Colors.green));
                                        },
                                      ),
                                    ),
                                  )),
                        )
                      : Text(
                          'no Data Found',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                ],
              )
            : Text('no Data Found'),
      ),
    );
  }
}
