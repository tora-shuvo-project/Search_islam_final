import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/quran/widget/quran_details_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:search_islam/view/widget/download_dialog_widget.dart';

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

    Provider.of<QuraanShareefProvider>(context, listen: false)
        .initializeAudioModel(widget.suraID, Provider.of<QuraanShareefProvider>(context, listen: false).getQareName());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Consumer<QuraanShareefProvider>(
          builder: (context, quranProvider, child) => Container(
            height: 60,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(8),
            color: Colors.green,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(flex: 3, child: Text(quranProvider.getQareName(), style: poppinsExtraLight.copyWith(color: Colors.white, fontSize: 16))),
                IconButton(
                  icon: Icon(quranProvider.isPlaying ? Icons.play_arrow : Icons.pause, color: Colors.white),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              child: DownloadDialogWidget(title: Strings.odioti, percent: quranProvider.showPercentage));
                        });

                    quranProvider.playAudioANdDownload(
                        context: context,
                        suraNo: widget.suraID,
                        url: quranProvider.audioModel.suraLink.trim(),
                        qareName: quranProvider.getQareName());
                  },
                ),
                IconButton(
                    icon: Icon(Icons.stop, color: Colors.white),
                    onPressed: () {
                      quranProvider.stopSuraAudioPlayer();
                    })
              ],
            ),
          ),
        ),
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
