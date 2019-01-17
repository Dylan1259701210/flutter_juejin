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
          var tabList =  snapshot.data['d']['categoryList'];
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
        body:TabBarView(
          children: widget.tabList.map((cate){
            return ArticleList(categories: cate,);
          }).toList(),
        )
      ),
    );
  }
}


class ArticleList extends StatefulWidget {
  final Map categories;

  ArticleList({Key key, this.categories}):super(key:key);

  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  List articleList;

  Future getArticleList({int limit =20 ,String category})async{
      final String url = 'https://timeline-merger-ms.juejin.im/v1/get_entry_by_rank?src=${httpHeaders['X-Juejin-Src']}&uid=${httpHeaders['X-Juejin-Uid']}&device_id=${httpHeaders['X-Juejin-Client']}&token=${httpHeaders['X-Juejin-Token']}&limit=${limit}&category=${category}';
      //print(url);
      try{
        Response response;
        Dio dio = new Dio();
        response = await dio.get(Uri.encodeFull(url));
        if(response.statusCode == 200){
        
          return response.data;
        }else{
          throw Exception('Failed to load post');
        }
      }catch(e){
        return print(e);
      }
  }

  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
       future:getArticleList(category : widget.categories['id']),
       builder:(context,snapshot){
         if(snapshot.hasData){
           articleList = snapshot.data['d']['entrylist'];
           return ListView.builder(
             itemCount:articleList.length,
             itemBuilder: (context,index){
               var item  = articleList[index];
               return createItem(item);
             },
           );
         }else if( snapshot.hasError){
           return Center(
             child: Text("error2>>>>>>>>>>>>>>>>>>>>>${snapshot.error}"),
           );
         }
         return CupertinoActivityIndicator();
       }
     );
  }
  // 单个文章
  Widget createItem(articleInfo){
    var objectId = articleInfo['originalUrl'].substring(articleInfo['originalUrl'].lastIndexOf('/')+1);
    return Container(
      margin : EdgeInsets.only(bottom:10.0),
      padding: EdgeInsets.only(top:10.0,bottom:10.0),
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        onPressed: (){},
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: null,
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(articleInfo['user']['avatarLarge']),
                      ),
                      Padding(padding: EdgeInsets.only(right:5.0),),
                      Text(
                        articleInfo['user']['username'],
                        style: TextStyle(color:Colors.black),
                      )
                    ],
                  ), 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   
                    FlatButton(
                      onPressed: null,
                      child: Text(articleInfo['tags'][0]['title']),
                    )

                  ],
                )
              ],
            ),
            ListTile(
              title:Text(articleInfo['title']),
              subtitle: Text(
                articleInfo['summaryInfo'],
                maxLines:2,
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: null,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Padding(padding: EdgeInsets.only(right:5.0)),
                      Text(articleInfo['collectionCount'].toString())
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: null,
                  child: Row(children: <Widget>[
                    Icon(Icons.message),
                    Padding(padding: EdgeInsets.only(right:5.0),),
                    Text(articleInfo['commentsCount'].toString())
                  ],),
                )
              ],
            )
          ],
        ),
      ),
      color:Colors.white
    );
  }
}