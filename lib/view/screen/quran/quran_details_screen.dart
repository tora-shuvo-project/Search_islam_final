import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/quran/widget/quran_details_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class QuranDetailsScreen extends StatefulWidget {
  final int suraID;
  final String title;

  QuranDetailsScreen({@required this.suraID, @required this.title});

  @override
  _QuranDetailsScreenState createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<QuraanShareefProvider>(context, listen: false).initializeAyatBySuraId(widget.suraID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: CustomAppBar(title: widget.title, isBackgroundPrimaryColor: true, isAyatScreen: true),
            preferredSize: Size(MediaQuery.of(context).size.width, 120)),
        body: Consumer<QuraanShareefProvider>(
          builder: (context, quranProvider, child) => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Divider(color: Colors.white, height: 1, thickness: 0.7),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)]),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
                child: Text(
                  Strings.bismillahirahmanirRahim,
                  style: madina.copyWith(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20),
              quranProvider.getAllSuraAyat != null
                  ? ListView.builder(
                      itemCount: quranProvider.getAllSuraAyat.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return QuranDetailsWidget(ayatModel: quranProvider.getAllSuraAyat[index], index: index);
                      })
                  : CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
