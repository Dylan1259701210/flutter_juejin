import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'dynamic.dart';
import 'discovery.dart';
import 'book.dart';
import 'mine.dart'; 



class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    new BottomNavigationBarItem(
      icon: new Icon(CupertinoIcons.home),
      title: new Text('首页'),
    ),
    new BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.refresh_circled),
        title: new Text('动态')),
    new BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.search), 
        title: new Text('发现')),
     new BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.book), 
        title: new Text('小册')),
    new BottomNavigationBarItem(
        icon: new Icon(CupertinoIcons.profile_circled), 
        title: new Text('我'))
  ];

  final List tabBodies = [
    HomePage(),
    DynamicPage(),
    DiscoveryPage(),
    BookPage(),
    MinePage()

  ];
  int currentIndex = 0;
  var currentPage;
    @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items:bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];            
          });
        },
      ),
      body:currentPage,
    );
  }
}