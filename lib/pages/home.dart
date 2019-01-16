import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import '../config/httpHeaders.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //获取掘金的分类

  Future getCategories() async{
    final response = await http.get(
      'https://gold-tag-ms.juejin.im/v1/categories',
      headers:httpHeaders
    );
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: child,
    );
  }
}