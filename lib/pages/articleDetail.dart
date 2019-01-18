import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import '../config/httpHeaders.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class ArticleDetail extends StatefulWidget {
   final String objectId;
   final Map articleInfo;
   ArticleDetail({Key key, this.objectId,this.articleInfo}):super(key:key);
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  Map content;

  Future getContetn() async{
    final String url = 'https://post-storage-api-ms.juejin.im/v1/getDetailData?uid=${httpHeaders['X-Juejin-Src']}&device_id=${httpHeaders['X-Juejin-Client']}&token=${httpHeaders['X-Juejin-Token']}&src=${httpHeaders['X-Juejin-Src']}&type=entryView&postId=${widget.objectId}';
    Response response;
    Dio dio = new Dio();
    response = await dio.get(Uri.encodeFull(url));
   
    if(response.statusCode ==200){
       print('>>>>>>>>>>>>>>>>>>>>>${response}');
      return response.data;
    }else{
      throw Exception('Falid to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
      var articleInfo = widget.articleInfo;
      return FutureBuilder(
        future:getContetn(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
                leading: IconButton(
                  padding:EdgeInsets.all(0.0),
                  icon:Icon(Icons.chevron_left),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                title:Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(articleInfo['user']['avatarLarge']),
                    ),
                    Padding(padding:EdgeInsets.only(right:5.0)),
                    Text(
                      articleInfo['user']['username'],
                      style: TextStyle(
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                actions:<Widget>[
                  IconButton(
                     icon:Icon(
                      Icons.file_upload,
                      color:Colors.blue,
                    ),
                  onPressed:null
                ),
                ]
              ),
              bottomNavigationBar: Container(
                height: 50.0,
                padding: EdgeInsets.only(left: 10.0,right:10.0),
                decoration: BoxDecoration(
                  color:Color.fromRGBO(244, 245, 245, 1.0),
                  border: Border(
                    top:BorderSide(width:0.2,color:Colors.grey)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite_border,
                          color:Colors.green,
                          size:24.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right:20.0)
                        ),
                        Icon(
                          Icons.message,
                          color:Colors.grey,
                          size:24.0
                        ),
                        Padding(
                          padding:EdgeInsets.only(right:20.0)
                        ),
                        Icon(
                          Icons.playlist_add,
                          color:Colors.grey,
                          size:24.0
                        )
                      ],
                    ),
                    Text('喜欢:${articleInfo['collectionCount']} 评论: ${articleInfo['commentsCount']}')
                  ],
                ),
              ),
              // body:Container(
              //   child:Text(snapshot.data['d']['content'].toString())
              // )
              body:ListView(
                children: <Widget>[
                  Column(children: <Widget>[
                        Container(
                          color:Colors.white,
                         
                          width: 750.0,
                          padding: EdgeInsets.all(10.0),
                          child:Text(
                            articleInfo['title'],
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                       Container(
                        color:Colors.white,
                        child: HtmlView(
                          data:snapshot.data['d']['content']
                        ),
                      )
                  ],)
                 
                ],
              )
            );
          }else if( snapshot.hasError ){
            return Container(
              color:Colors.white,
              child: Text('error2>>>>>>>>>>>>>>:${snapshot.error}'),
            );
          }
          return Container(
            color: Color.fromRGBO(244, 245, 245, 1.0),
            child: CupertinoActivityIndicator(),
          );
        },
      );
  }
}