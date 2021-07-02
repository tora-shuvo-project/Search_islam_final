import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/tasbih_provider.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_button.dart';
import 'package:search_islam/view/widget/show_custom_snakbar.dart';

class TasbihScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.tasbih),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {
              showCustomSnackBar(Strings.inshaallah_poroborti_update, context);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              Provider.of<TasbihProvider>(context, listen: false).resetCount();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.green.withOpacity(.1),
          child: Consumer<TasbihProvider>(
            builder: (context, tasbihProvider, child) => Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [Color(0xffFFFFFF), Color(0xffFFFFFF)]),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 2, offset: Offset(0, 3) // changes position of shadow
                          )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${Strings.tasbih_select_korun}',
                        style: kalpurus.copyWith(fontWeight: FontWeight.w700),
                      ),
                      DropdownButton<String>(
                          items: tasbihData.map((String district) {
                            return new DropdownMenuItem<String>(
                              value: district,
                              child: new Text(
                                district,
                                style: poppinsRegular,
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                          value: tasbihProvider.tasbihTitle,
                          onChanged: tasbihProvider.setTasbihTitle),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: InkWell(
                    onTap: () async {
                      tasbihProvider.updateCount();
                    },
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          Images.tasbih_logo,
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                                child: Text(
                              tasbihProvider.count.toString(),
                              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                            ))),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  buttonText: 'Reset',
                  onTap: () {
                    tasbihProvider.resetCount();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
