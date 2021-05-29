import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_islam/data/model/comment_feedback_models.dart';
import 'package:search_islam/data/model/comment_models.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';

class CustomeButtomSheet extends StatefulWidget {
  final String id;

  CustomeButtomSheet(this.id);

  @override
  _CustomeButtomSheetState createState() => _CustomeButtomSheetState();
}

class _CustomeButtomSheetState extends State<CustomeButtomSheet> {
  final _formKey = GlobalKey<FormState>();

  ComentFeedBackModels comentFeedBackModels;
  CommentModels commentModels;
  String date;
  String dateKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comentFeedBackModels = ComentFeedBackModels();
    commentModels = CommentModels();
    DateTime now = DateTime.now();
    date = DateFormat('yyyy-MM-dd hh:mm a').format(now);
    dateKey = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void _saveCommnt() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      comentFeedBackModels.id = widget.id;
      comentFeedBackModels.date = date;
      comentFeedBackModels.dateKey = dateKey;

      FirestoreDatabaseHelper.addFeedBack(comentFeedBackModels).then((_) {
        setState(() {
          //Toast.show('Save Your Comment',context);
          Navigator.of(context).pop();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'মন্তব্যঃ',
                        style: TextStyle(fontSize: 20, decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'আপনার নাম লিখুন *', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'This field must ne required';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          comentFeedBackModels.answername = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'আপনার মতামত লিখুন *', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'comment section don\'t be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          comentFeedBackModels.answer = value;
                        },
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
          Container(
            width: double.infinity,
            child: TextButton(
              child: Text(
                'মন্তব্য সম্পন্ন করুন',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              onPressed: () {
                _saveCommnt();
              },
            ),
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
