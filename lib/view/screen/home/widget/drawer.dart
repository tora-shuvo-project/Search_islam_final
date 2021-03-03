import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          color: Colors.green,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "images/app_logo.png",
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Search Islam\n(সত্যের সন্ধানে)',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'images/home.png',
                  width: 25,
                ),
              ),
              title: Text("হোম")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ('images/quran.png'),
                  width: 25,
                ),
              ),
              title: Text("সিলেক্ট কুরআন"),
              trailing: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {},
              )),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ('images/settings.png'),
                  width: 25,
                ),
              ),
              title: Text("সেটিংস")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ('images/mosque (3).png'),
                  width: 25,
                ),
              ),
              title: Text("চারপাশের মসজিদ")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ('images/labbaikkallahumma.png'),
                  width: 25,
                ),
              ),
              title: Text("লাব্বাইকাল্লামুম্মা লাব্বাইক")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ('images/donate.png'),
                  width: 25,
                ),
              ),
              title: Text("দান করুন")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ('images/developer.png'),
                  width: 25,
                ),
              ),
              title: Text("আমাদের সম্পর্কে জানুন")),
        ),
        Container(
          height: 1,
          color: Colors.green.withOpacity(.4),
        ),
        Container(
          color: Colors.green.withOpacity(.5),
          child: ListTile(
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  ('images/share.png'),
                  width: 25,
                ),
              ),
              title: Text("শেয়ার করুণ")),
        ),
        Container(
          height: 250,
          color: Colors.green.withOpacity(.4),
        ),
      ],
    );
  }
}
