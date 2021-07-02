import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_islam/data/model/janun_model.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/show_custom_snakbar.dart';
import 'package:share/share.dart';

class NosihatDetailsScreen extends StatelessWidget {
  final int topicNo;
  final String title;

  NosihatDetailsScreen({this.topicNo = 0, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: FutureBuilder(
          future: FirestoreDatabaseHelper.nosihatList(topicNo),
          builder: (context, AsyncSnapshot<List<JanunModelNosihat>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 3, blurRadius: 3, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                child: Text('${index + 1}', style: poppinsRegular.copyWith(color: Colors.white)),
                                radius: 14,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Share.share(
                                            '${snapshot.data[index].title.replaceAll("\\n", "\n")}\n\n${snapshot.data[index].reference.replaceAll("\\n", "\n")}\n\nDownload Islamic Apps (Search Islam)',
                                            subject: 'ইসলামিক নসিহাত');
                                      },
                                      icon: Icon(Icons.share, color: Colors.blueGrey)),
                                  IconButton(
                                      onPressed: () {
                                        String message =
                                            '${snapshot.data[index].title.replaceAll("\\n", "\n")}\n\n${snapshot.data[index].reference.replaceAll("\\n", "\n")}\n\nDownload Islamic Apps (Search Islam)';

                                        Clipboard.setData(ClipboardData(text: message));
                                        showCustomSnackBar(Strings.copy_kora_hoyeche, context);
                                      },
                                      icon: Icon(Icons.copy, color: Colors.blueGrey)),
                                ],
                              ),
                            ],
                          ),
                          Text('${snapshot.data[index].title.replaceAll('\\n', '\n')}',
                              textAlign: TextAlign.justify, style: kalpurus.copyWith(fontSize: 16)),
                          snapshot.data[index].reference != null
                              ? Text('${snapshot.data[index].reference.replaceAll('\\n', '\n')}',
                                  textAlign: TextAlign.justify, style: kalpurus.copyWith(fontSize: 14, color: Colors.grey))
                              : SizedBox.shrink(),
                        ],
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
    );
  }
}
