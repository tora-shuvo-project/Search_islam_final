import 'package:flutter/material.dart';
import 'package:search_islam/data/model/sura_model.dart';
import 'package:search_islam/helper/convert_eng_to_bangla_number.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/styles.dart';

class SuraWidget extends StatelessWidget {
  final SuraModel suraModel;

  SuraWidget({this.suraModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(Images.number_icon, height: 50, width: 50, fit: BoxFit.cover,color: Colors.grey,),
                  Container(width: 50, height: 50, alignment: Alignment.center, child: Text('${convertEngToBangla(suraModel.suraNo)}'))
                ],
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Row(children: [
                    Text(suraModel.banglaTranslator),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Text('( ${suraModel.arbiSuraNam} )', style: madina.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE))
                  ]),
                  Text(suraModel.banglaMeaning)
                ]),
              ),
              InkWell(
                  onTap: (){

                  },
                  child: Icon(Icons.info, color: Colors.grey)),
            ],
          ),
          SizedBox(height: 5),
          Container(
              height: 3,
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: [const Color(0xffffffff), const Color(0xff178723), const Color(0xffffffff)])))
        ],
      ),
    );
  }
}
