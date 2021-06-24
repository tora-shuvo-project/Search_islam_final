import 'package:flutter/material.dart';
import 'package:search_islam/data/model/janun_model.dart';
import 'package:search_islam/view/widget/custom_button.dart';

List<JanunModel> janunList = [
  JanunModel(
      id: 111,
      title: 'অধীনস্তদের সঙ্গে রাসূল সাল্লাল্লাহু আলাইহি ওয়াসাল্লাম এর ব্যবহার:',
      description: 'নবী (সাল্লালাহু আলাইহি ওয়া সাল্লাম) র বৈশিষ্টঃ'),
  JanunModel(id: 112, title: 'রাসূল (সা.) এর সৌজন্যমূলক ব্যবহারে অনন্য দৃষ্টান্ত:', description: 'নবী (সাল্লালাহু আলাইহি ওয়া সাল্লাম)এর বংশ পরিচয়:'),
];

class TestScreen extends StatefulWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  // addData() {
  //   for (var value in janunList) {
  //     FirestoreDatabaseHelper.addJanunToFirebase(value).then((_) {
  //       setState(() {
  //         print(value.id);
  //       });
  //     });
  //   }
  //   ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [CustomButton(buttonText: 'save ')],
      ),
    );
  }
}
