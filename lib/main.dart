import 'package:flutter/material.dart';

void mian() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home:IndexPage(),
      theme:ThemeData(
        splashColor:Colors.transparent,
        bottomAppBarColor: Color.fromRGBO(244, 245,245, 1.0),
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        scaffoldBackgroundColor:  Color.fromRGBO(244, 245, 245, 1.0),
        primaryIconTheme: IconThemeData()
      )
    );
  }
}