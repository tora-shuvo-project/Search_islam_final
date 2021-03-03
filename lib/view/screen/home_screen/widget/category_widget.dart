import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryWidget extends StatelessWidget {
  final String title;
  final Widget routeWidget;
  final String iconUrl;

  CategoryWidget({this.title, this.routeWidget, this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (routeWidget != null) Navigator.of(context).push(ScaleRoute(page: routeWidget));
      },
      child: Column(
        children: <Widget>[Card(child: Container(padding: EdgeInsets.all(15), child: SvgPicture.asset(iconUrl, height: 40, width: 40))), Text(title)],
      ),
    );
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({@required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
