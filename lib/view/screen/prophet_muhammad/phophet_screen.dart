import 'package:flutter/material.dart';
import 'package:search_islam/data/model/janun_model.dart';
import 'package:search_islam/helper/firestore_database_helper.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/prophet_muhammad/prophet_details_screen.dart';

class ProphetScreen extends StatelessWidget {
  const ProphetScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.phophet),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         //Navigator.of(context).push(MaterialPageRoute(builder: (_)=>TestScreen()));
        //       },
        //       icon: Icon(Icons.add))
        // ],
      ),
      body: Center(
        child: FutureBuilder(
          future: FirestoreDatabaseHelper.janunLists(),
          builder: (context, AsyncSnapshot<List<JanunModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProphetDetailsScreen(janunModel: snapshot.data[index])));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(10, 8, 10, 0),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 6, blurRadius: 10, offset: Offset(0, 3)),
                          ],
                        ),
                        child: Text(
                          '${snapshot.data[index].title}',
                          style: kalpurus.copyWith(fontSize: 15),
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
    );
  }
}
