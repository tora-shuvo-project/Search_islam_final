import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/data/model/comment_feedback_models.dart';
import 'package:search_islam/data/model/comment_models.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/comment/widget/custome_buttom_sheet.dart';
import 'package:share/share.dart';

class CommentQuestionAnswerScreen extends StatefulWidget {
  final CommentModels commentModels;

  CommentQuestionAnswerScreen(this.commentModels);

  @override
  _CommentQuestionAnswerScreenState createState() => _CommentQuestionAnswerScreenState();
}

class _CommentQuestionAnswerScreenState extends State<CommentQuestionAnswerScreen> {
  int totalAns;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirestoreDatabaseHelper.getAllReplySpecifyQuestion(widget.commentModels.id).then((value) {
      setState(() {
        totalAns = value.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              FirestoreDatabaseHelper.getAllReplySpecifyQuestion(widget.commentModels.id).then((value) {
                setState(() {
                  totalAns = value.length;
                });
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            tooltip: 'Share',
            onPressed: () {
              setState(() {
                Share.share(
                    'বিভাগঃ ${widget.commentModels.category}\nসময়ঃ ${widget.commentModels.date}\nপ্রশ্নঃ ${widget.commentModels.question} \n© Search Islam');
              });
            },
          ),
          TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: CustomeButtomSheet(widget.commentModels.id),
                          ),
                        ));
              },
              icon: Icon(Icons.comment, color: Colors.white),
              label: Text('Comment', style: poppinsRegular.copyWith(color: Colors.white))),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Card(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Text('প্রশ্নঃ ${widget.commentModels.question}', style: kalpurus.copyWith(fontSize: 16))),
          ),
          Card(
            child:
                Container(padding: EdgeInsets.all(8), child: Text('বিভাগঃ ${widget.commentModels.category}', style: kalpurus.copyWith(fontSize: 16))),
          ),
          Card(
            child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(totalAns == null ? '' : 'উত্তরঃ $totalAns টি', style: kalpurus.copyWith(fontSize: 16)),
                    Text('সময়ঃ ${widget.commentModels.date}', style: kalpurus.copyWith(fontSize: 16))
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Answer Section:',
              style: poppinsMedium.copyWith(fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: FutureBuilder(
              future: FirestoreDatabaseHelper.getAllReplySpecifyQuestion(widget.commentModels.id),
              builder: (context, AsyncSnapshot<List<ComentFeedBackModels>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data.length > 0
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                                child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'উত্তর কারীর নামঃ ${snapshot.data[index].answername}',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text(
                                    'উত্তর দেওয়ার সময়ঃ ${snapshot.data[index].date}',
                                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                                  ),
                                  Text(
                                    'উত্তরঃ ${snapshot.data[index].answer}',
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                                  ),
                                ],
                              ),
                            ));
                          })
                      : Text('No Answer');
                }
                if (snapshot.hasError) {
                  return Text('Data Fetch a Problems');
                }
                return CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
