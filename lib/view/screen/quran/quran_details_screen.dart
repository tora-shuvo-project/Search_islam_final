import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/data/model/para_models.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/quran/widget/ayat_widget.dart';
import 'package:search_islam/view/screen/quran/widget/quran_settings_drawer.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';
import 'package:search_islam/view/widget/download_dialog_widget.dart';

class QuranDetailsScreen extends StatefulWidget {
  final int suraID;
  final String title;
  final ParaModel paraModel;
  final bool isFromSuraScreen;

  QuranDetailsScreen({this.suraID, @required this.title, this.paraModel, this.isFromSuraScreen = true});

  @override
  _QuranDetailsScreenState createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    if (widget.isFromSuraScreen) {
      Provider.of<QuraanShareefProvider>(context, listen: false)
          .initializeAudioModel(widget.suraID, Provider.of<QuraanShareefProvider>(context, listen: false).getQareName);
      Provider.of<QuraanShareefProvider>(context, listen: false).initializeAyatBySuraId(widget.suraID);
      Provider.of<QuraanShareefProvider>(context, listen: false).saveSuraNo(widget.suraID);
    } else {
      Provider.of<QuraanShareefProvider>(context, listen: false).initializeAyatByParaId(widget.paraModel.paraNo);
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Provider.of<QuraanShareefProvider>(context, listen: false).dismissAudio();
          Navigator.of(context).pop();
          return Future.value(true);
        },
        child: Scaffold(
          key: _drawerKey,
          endDrawer: QuranSettingsDrawer(suraNo: widget.suraID),
          floatingActionButton: Consumer<QuraanShareefProvider>(
            builder: (context, quranProvider, child) => FloatingActionButton(
              onPressed: () {
                if (widget.isFromSuraScreen) {
                  quranProvider.playAudioANdDownload(
                      context: context,
                      url: quranProvider.audioModel.suraLink.trim(),
                      qareName: quranProvider.getQareName,
                      percentFunction: (value) {
                        if (value == 1) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                    child: DownloadDialogWidget(title: Strings.odioti));
                              });
                        }
                      });
                } else {
                  quranProvider.playAudioByOnline(
                      context: context,
                      audioUrl: quranProvider.getQareName == Strings.abdur_rahman_sudaies_english
                          ? widget.paraModel.audioSudais
                          : quranProvider.getQareName == Strings.sad_al_gamidi_english
                              ? widget.paraModel.audioGumadi
                              : quranProvider.getQareName == Strings.misare_bin_rased_al_afsi_english
                                  ? widget.paraModel.audioMishary
                                  : quranProvider.getQareName == Strings.salah_budir_english
                                      ? widget.paraModel.audioBudair
                                      : widget.paraModel.audioAlajmi);
                }
              },
              child: Icon(!quranProvider.isPlaying ? Icons.play_arrow : Icons.pause, color: Colors.white),
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          appBar: PreferredSize(
              child: CustomAppBar(title: widget.title, isBackgroundPrimaryColor: true, isAyatScreen: true, drawerKey: _drawerKey),
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
                quranProvider.getAllAyat.length > 0
                    ? ListView.builder(
                        itemCount: quranProvider.getAllAyat.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AyatWidget(ayatModel: quranProvider.getAllAyat[index], index: index, isSuraWiseShowAyat: widget.isFromSuraScreen);
                        })
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: Center(
                            child: Text(Strings.onugroho_kore_ektu_wait_korun,
                                style: kalpurus.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Colors.green))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
