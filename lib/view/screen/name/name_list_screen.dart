import 'package:flutter/material.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/names/names_details_screen.dart';

class NameListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.islamic_name)),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        children: [
          _title(context,title: Strings.ek_sobder_celeder_islamic_name, id: '1'),
          _title(context,title: Strings.dui_sobder_celeder_islamic_name, id: '2'),
          _title(context,title: Strings.meye_childreen_sundorName, id: '3'),
          _title(context,title: Strings.eksobde_islamic_name_for_female, id: '4'),
          _title(context,title: Strings.allah_robbul_talaminer_gunbacok_name, id: '5'),
          _title(context,title: Strings.nobi_rasul_name, id: '6'),
          _title(context,title: Strings.bodor_sahabi_name, id: '7'),
          _title(context,title: Strings.mohila_sahabIder_namer_talika, id: '8'),
          _title(context,title: Strings.sahabi_ra_er_namer_talika, id: '9'),
          _title(context,title: Strings.jannater_susonbad_prapto, id: '10'),
        ],
      ),
    );
  }

  Widget _title(BuildContext context,{@required String title, @required String id}) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NamesDetailsScreen(title: title,categoryID: id)));
      },
      child: Container(
          height: 45,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1))],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Text(title, style: kalpurus.copyWith(fontSize: 15))),
    );
  }
}
