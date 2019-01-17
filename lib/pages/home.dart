import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import '../config/httpHeaders.dart';
import 'package:dio/dio.dart';




class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //获取掘金的分类
  Future getCategories() async{
    try{
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response = await dio.get('https://gold-tag-ms.juejin.im/v1/categories');
      if(response.statusCode==200){
          return response.data;
      }else{
          throw Exception('Falid to load post');
      }
    
    }catch(e){
      return print(e);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:getCategories(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          var tabList = snapshot.data['d']['categoryList'];
          return CreatePage( tabList:tabList  );
        }else if(snapshot.hasError){
          return Text('error1>>>>>>>>>>>>>>>>>:${snapshot.error}');
        }
        return Container(
          color: Color.fromRGBO(244, 245, 245, 1.0)
        );
      },
    );
  }
}


//创建页面

class CreatePage extends StatefulWidget {
  final List tabList;

  CreatePage({Key key,this.tabList}):super(key:key);

  _CreatePageState createState() => _CreatePageState();

}

class _CreatePageState extends State<CreatePage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabList.length,
      child: Scaffold(
        appBar:AppBar(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable:true,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs : widget.tabList.map((tab){
              return Tab(text:tab['name']);
            }).toList(),

          ),
          actions:<Widget>[
            IconButton(
              icon:Icon( Icons.add, color:Colors.blue ),
              onPressed:(){}
            )
          ]
        ),
        body:Center(
          child:Text('准备'),
        )
      ),
    );
  }
}