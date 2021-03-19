import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/doya_provider.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/utill/styles.dart';
import 'package:search_islam/view/screen/doya/widget/bisoy_vittik_widget.dart';
import 'package:search_islam/view/screen/doya/widget/sokol_doya_widget.dart';
import 'package:search_islam/view/widget/custom_app_bar.dart';

class DoyaScreen extends StatelessWidget {
  final int initialPage;

  DoyaScreen({this.initialPage = 0});

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: initialPage);

    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              child: CustomAppBar(title: Strings.doya_somuh, isBackgroundPrimaryColor: true),
              preferredSize: Size(MediaQuery.of(context).size.width, 70)),
          body: Consumer<DoyaProvider>(
            builder: (context, authProvider, child) => Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xff178723), const Color(0xff27AB4B)])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Column(
                          children: [
                            Text(Strings.bisoy_somuh,
                                style: authProvider.selectedIndex == 0
                                    ? poppinsSemiBold.copyWith(color: Colors.white70)
                                    : poppinsRegular.copyWith(color: Colors.white54)),
                            Container(
                                height: 1,
                                width: 75,
                                margin: EdgeInsets.only(top: 8),
                                color: authProvider.selectedIndex == 0 ? Colors.white70 : Colors.transparent),
                          ],
                        ),
                      ),
                      SizedBox(width: 25),
                      InkWell(
                        onTap: () => _pageController.animateToPage(1, duration: Duration(seconds: 1), curve: Curves.easeInOut),
                        child: Column(
                          children: [
                            Text(Strings.sokol_doya_somuh,
                                style: authProvider.selectedIndex == 1
                                    ? poppinsSemiBold.copyWith(color: Colors.white70)
                                    : poppinsRegular.copyWith(color: Colors.white54)),
                            Container(
                                height: 1,
                                width: 90,
                                margin: EdgeInsets.only(top: 8),
                                color: authProvider.selectedIndex == 1 ? Colors.white70 : Colors.transparent),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: 2,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      if (authProvider.selectedIndex == 0) {
                        return BisoyVittikWidget();
                      } else {
                        return SokolDoyaWidget();
                      }
                    },
                    onPageChanged: (index) {
                      authProvider.updateSelectedIndex(index);
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
