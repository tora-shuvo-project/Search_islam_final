import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_islam/provider/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Consumer<ThemeProvider>(
            builder:(context, notifier, child) =>
                SwitchListTile(
                  title: Text("Dark Mode"),
                  onChanged:(value){
                    notifier.toggleTheme();
                  } ,
                  value: notifier.darkTheme ,
                ),
          ),
          ListTile(
            title: Text('Shuvo khan'),
          )
        ],
      ),
    );
  }
}
