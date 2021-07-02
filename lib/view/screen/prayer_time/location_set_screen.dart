import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class LocationSetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar:
          PreferredSize(child: CustomAppBar(title: Strings.location, isLocation: false), preferredSize: Size(MediaQuery.of(context).size.width, 120)),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Consumer<LocationProvider>(
          builder: (context, locationProvider, child) => Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
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
                        '${Strings.zila_nirbacon_korun}',
                        style: kalpurus.copyWith(fontWeight: FontWeight.w700),
                      ),
                      DropdownButton<String>(
                        items: locationProvider.allDistrictName.map((String district) {
                          return new DropdownMenuItem<String>(
                            value: district,
                            child: new Text(
                              district,
                              style: poppinsRegular,
                            ),
                          );
                        }).toList(),
                        isExpanded: true,
                        value: locationProvider.initializeDistrict,
                        onChanged: (value) {
                          locationProvider.setDistrictName(value);
                        },
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    ));
  }
}
