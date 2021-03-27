import 'package:compasstools/compasstools.dart';
import 'package:flutter/material.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class KiblaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              child: CustomAppBar(title: Strings.kibla, isLabbayekScreen: true), preferredSize: Size(MediaQuery.of(context).size.width, 70)),
          body: Container(
            child: StreamBuilder(
              stream: Compasstools.azimuthStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: Center(
                          child: new RotationTransition(
                            turns: new AlwaysStoppedAnimation(-snapshot.data / 360),
                            child: Image.asset(Images.compass, width: double.infinity, height: double.infinity),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        alignment: Alignment.center,
                        child: Text(
                          Strings.bises_drostobbo_device_er,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      )
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text(Strings.ei_option_ti_apnar_upossotit, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.black)),
                  );
                }
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                ));
              },
            ),
          )),
    );
  }
}
