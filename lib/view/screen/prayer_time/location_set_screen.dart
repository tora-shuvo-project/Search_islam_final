import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/location_provider.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

// ignore: must_be_immutable
class LocationSetScreen extends StatelessWidget {
  Completer<GoogleMapController> _completer = Completer();

  void _onmapCreated(GoogleMapController controller) {
    _completer.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context, listen: false).getUserLocation();

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
                SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Container(height: 50, width: 3, color: Colors.green),
                    SizedBox(width: 10),
                    Expanded(child: Text("${Strings.gps_na_paoya_gele}", style: kalpurus)),
                  ],
                ),
                SizedBox(height: 25),
                Text("${Strings.elaka_nirbaconer_jonno}", style: kalpurus.copyWith(fontWeight: FontWeight.bold)),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: locationProvider.selectedRadio,
                          activeColor: Colors.green,
                          onChanged: locationProvider.handleRadioValueChange,
                        ),
                        Text("${Strings.nirdistro_zila_select_korun}")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: locationProvider.selectedRadio,
                          activeColor: Colors.green,
                          onChanged: locationProvider.handleRadioValueChange,
                        ),
                        Text("${Strings.gps_er_maddome_automatc}")
                      ],
                    ),
                  ],
                ),
                locationProvider.currentLocation != null
                    ? Container(
                        height: 400,
                        child: GoogleMap(
                          onMapCreated: _onmapCreated,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  locationProvider.currentLocation.latitude ?? 23.7115253, locationProvider.currentLocation.longitude ?? 90.4111451),
                              zoom: 17),
                          mapType: MapType.satellite,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          //markers: markers,
                        ))
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
