import 'package:flutter/material.dart';
import 'package:search_islam/data/model/comment_models.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';
import 'package:search_islam/view/screen/comment/comment_add_Pages.dart';
import 'package:search_islam/view/screen/comment/comment_question_answer_screen.dart';
import 'package:search_islam/view/screen/home/home_screen.dart';

class CommentQuestionScreen extends StatefulWidget {
  @override
  _CommentQuestionScreenState createState() => _CommentQuestionScreenState();
}

class _CommentQuestionScreenState extends State<CommentQuestionScreen> {
  List<CommentModels> comments = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    FirestoreDatabaseHelper.getAllCommentModels().then((value) {
      for (int i = value.length - 1; i >= 0; i--) {
        setState(() {
          comments.add(value[i]);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Question'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentAddPages()));
              },
              tooltip: 'Add Question',
            ),
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: FirestoreDatabaseHelper.getAllCommentModels(),
            builder: (context, AsyncSnapshot<List<CommentModels>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: comments.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            CommentModels commentModels = CommentModels();
                            commentModels.seen = comments[index].seen + 1;
                            commentModels.id = comments[index].id;
                            commentModels.name = comments[index].name;
                            commentModels.date = comments[index].date;
                            commentModels.category = comments[index].category;
                            commentModels.question = comments[index].question;

                            FirestoreDatabaseHelper.updateFeedBack(commentModels);

                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentQuestionAnswerScreen(comments[index])));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(flex: 2, child: Text('বিভাগঃ ${comments[index].category}')),
                                    Expanded(child: FittedBox(child: Text('Dt: ${comments[index].date}')))
                                  ],
                                ),
                                Text(
                                  'প্রশ্নঃ ${comments[index].question}',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text('দেখা হয়েছেঃ ${comments[index].seen} বার', style: TextStyle(color: Colors.green))],
                                ),
                                Text('প্রশ্নকারীর নামঃ ${comments[index].name}', style: TextStyle(color: Colors.pink))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
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
      ),
    );
  }
}
