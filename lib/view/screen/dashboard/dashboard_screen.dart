import 'package:flutter/material.dart';
import 'package:search_islam/utill/images.dart';
import 'package:search_islam/utill/string_resources.dart';
import 'package:search_islam/view/screen/dashboard/widget/fancy_bottom_nav_bar.dart';

class DashBoardScreen extends StatelessWidget {

  final PageController _pageController = PageController();
  final List<Widget> _screens = [
   Container(),
   Container(),
   Container(),
   Container(),
   Container(),
  ];
  final GlobalKey<FancyBottomNavBarState> _bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    int _pageIndex = 2;
    return WillPopScope(
      onWillPop: () async {
        if(_pageIndex != 0) {
          _bottomNavKey.currentState.setPage(0);
          return false;
        }else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: FancyBottomNavBar(
          key: _bottomNavKey,
          tabs: [
            FancyTabData(imagePath: Images.online_svg, title: Strings.online),
            FancyTabData(imagePath:Images.dua_svg, title: Strings.dua),
            FancyTabData(imagePath: Images.quran_svg, title: Strings.quran_sharif),
            FancyTabData(imagePath: Images.prayer_time_svg, title: Strings.prayer_time),
            FancyTabData(imagePath: Images.other_svg, title: Strings.other),
          ],
          onTabChangedListener: (int index) {
            _pageController.jumpToPage(index);
            _pageIndex = index;
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
            return _screens[index];
          },
        ),
      ),
    );
  }
}