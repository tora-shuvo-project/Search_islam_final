import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/labbayek_provider.dart';
import 'package:search_islam/provider/quran_sorif_provider.dart';
import 'package:search_islam/utill/dimensions.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/widget/custom_button.dart';

class DownloadDialogWidget extends StatelessWidget {
  final double percent;
  final title;
  final bool isLabbayekscreen;

  DownloadDialogWidget({this.percent, this.title, this.isLabbayekscreen = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Consumer<QuraanShareefProvider>(
          builder: (context, quranProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close)),
                ],
              ),
              Center(child: Text(title, style: kalpurus.copyWith(fontSize: 18, fontWeight: FontWeight.w600))),
              Center(
                child: Text(
                  isLabbayekscreen
                      ? '${Provider.of<LabbayekProvider>(context, listen: false).showPercentage == 1.0 ? Strings.sompurno_vabe_download_hocce : Strings.download_hoccce}'
                      : '${quranProvider.showPercentage == 1.0 ? Strings.sompurno_vabe_download_hocce : Strings.download_hoccce}',
                  style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Stack(children: [
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                          value:
                              isLabbayekscreen ? Provider.of<LabbayekProvider>(context).showPercentage : quranProvider.showPercentage),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                      child: Icon(percent == 1.00 ? Icons.check : Icons.navigate_next, color: Colors.white, size: 30),
                    ),
                  ),
                ]),
              ),
              isLabbayekscreen
                  ? Provider.of<LabbayekProvider>(context, listen: false).showPercentage == 1.0
                      ? SizedBox.shrink()
                      : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(Strings.somponno_hoccce, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                          Text('  ${Provider.of<LabbayekProvider>(context, listen: false).downloadMessahge}%',
                              style: kalpurus.copyWith(fontSize: 18, fontWeight: FontWeight.w600))
                        ])
                  : quranProvider.showPercentage == 1.0
                      ? SizedBox.shrink()
                      : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(Strings.somponno_hoccce, style: kalpurus.copyWith(fontSize: 16, fontWeight: FontWeight.w400)),
                          Text('  ${quranProvider.downloadMessahge}%', style: kalpurus.copyWith(fontSize: 18, fontWeight: FontWeight.w600))
                        ]),
              SizedBox(height: quranProvider.showPercentage == 1.0 ? 10 : 30),
              isLabbayekscreen
                  ? Provider.of<LabbayekProvider>(context, listen: false).showPercentage == 1.0
                      ? SizedBox.shrink()
                      : CustomButton(
                          buttonText: Strings.boundho_korun,
                          onTap: () {
                            Provider.of<LabbayekProvider>(context, listen: false).cancelDownload();
                            Navigator.of(context).pop();
                          },
                          color1: Color(0xff990212),
                          color2: Color(0xffde0808))
                  : quranProvider.showPercentage == 1.0
                      ? SizedBox.shrink()
                      : CustomButton(
                          buttonText: Strings.boundho_korun,
                          onTap: () {
                            quranProvider.cancelDownload();
                            Navigator.of(context).pop();
                          },
                          color1: Color(0xff990212),
                          color2: Color(0xffde0808)),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
