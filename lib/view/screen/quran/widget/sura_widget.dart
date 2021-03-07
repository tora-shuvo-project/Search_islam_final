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
                  Image.asset(
                    Images.number_icon,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    color: Colors.grey,
                  ),
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
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color: Color(0xFF737373),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                              child: Container(
                                color: Color(0xFFFFFFFF),
                                height: 330,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: const Radius.circular(10), topRight: const Radius.circular(10))),
                                    child: suraInfoBotomNavigationBar()),
                              ),
                            ),
                          );
                        });
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

  SingleChildScrollView suraInfoBotomNavigationBar() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'সূরা ${suraModel.banglaTranslator}',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
          Container(
              height: 3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                const Color(0xffffffff),
                const Color(0xff178723),
                const Color(0xffffffff),
              ]))),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'আরবি নামঃ:',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      '${suraModel.arbiSuraNam}',
                      style: TextStyle(fontSize: 19, color: Colors.green),
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'বাংলা অর্থঃ',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      '${suraModel.banglaMeaning}',
                      style: TextStyle(fontSize: 19, color: Colors.green),
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'সূরা নংঃ',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      '${suraModel.suraNo}',
                      style: TextStyle(fontSize: 19, color: Colors.green),
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'মোট আয়াতঃ',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      '${suraModel.ayatNo}',
                      style: TextStyle(fontSize: 19, color: Colors.green),
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'পারাঃ',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      '${suraModel.paraNumber}',
                      style: TextStyle(fontSize: 19, color: Colors.green),
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  'অবতীর্ণঃ',
                  style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                )),
                Expanded(
                    flex: 2,
                    child: Text(
                      '${suraModel.obotirno}',
                      style: TextStyle(fontSize: 19, color: Colors.green),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
