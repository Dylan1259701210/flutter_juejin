import 'package:flutter/material.dart';
import 'pages/index.dart';
//主函数（入口函数），下面我会简单说说Dart的函数
void main() =>runApp(MyApp());
// 声明MyApp类
class MyApp extends StatelessWidget{
  //重写build方法
  @override
  Widget build(BuildContext context){
    //返回一个Material风格的组件
   return MaterialApp(
      title:'高仿掘金案例',
       theme:ThemeData(
        splashColor:Colors.transparent,
        bottomAppBarColor: Color.fromRGBO(244, 245,245, 1.0),
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        scaffoldBackgroundColor:  Color.fromRGBO(244, 245, 245, 1.0),
        primaryIconTheme: IconThemeData()
      ),
      home:IndexPage()
    );
  }
}