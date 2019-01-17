import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import '../config/httpHeaders.dart';
import 'package:dio/dio.dart';

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
                      backgroundImage: NetworkImage(articleInfo['user']['username']),
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
            );
          }
        },
      );
  }
}