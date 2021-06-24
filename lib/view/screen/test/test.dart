import 'package:flutter/material.dart';
import 'package:search_islam/data/model/janun_model.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';
import 'package:search_islam/view/widget/custom_button.dart';

List<JanunModel> janunList = [
  JanunModel(
      id: 101,
      title: 'অধীনস্তদের সঙ্গে রাসূল সাল্লাল্লাহু আলাইহি ওয়াসাল্লাম এর ব্যবহার:',
      description: 'নবী (সাল্লালাহু আ'),
  JanunModel(id: 102, title: 'আল্লাহ কোথায় ?', description: 'নবী (সাল্লালাহুয়:'),
  JanunModel(id: 103, title: 'বিজ্ঞানের সাথে আল্লাহর পথে', description: 'নবী (সাল্লালাহুয়:'),
];

class TestScreen extends StatefulWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  addData() {
    for (var value in janunList) {
      FirestoreDatabaseHelper.addJanunToFirebase(value,isProphet: false).then((_) {
        setState(() {
          print(value.id);
        });
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [CustomButton(buttonText: 'save ',onTap: addData,)],
      ),
    );
  }
}
