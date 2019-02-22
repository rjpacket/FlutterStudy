import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/res/Config.dart';
import 'package:flutter_app/res/events.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class BaseActivity extends StatefulWidget{
  Widget topBar;
  Widget page;
  bool showLoading;

  BaseActivity({
    Key key,
    this.topBar,
    this.page,
    this.showLoading: false
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BaseActivityState();
  }
}

class BaseActivityState extends State<BaseActivity>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = ScreenUtil.getStatusBarHeight(context) + ScreenUtil.getAdaptWidth(context, Config.TOP_BAR_HEIGHT);
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: PreferredSize(
            child: widget.topBar,
            preferredSize: Size(ScreenUtil.getScreenWidth(context), totalHeight),
          ),
          body: widget.page,
        ),

        Offstage(
          offstage: !widget.showLoading,
          child: Container(
            constraints: BoxConstraints.expand(),
            color: Color.fromARGB(51, 0, 0, 0),
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '正在加载...',
                    style: Styles.normalText,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//全局的Get请求
requestGet({String baseUrl, String path, Map<String, String> params, callback, errorback}) async{

  if(baseUrl == null){
    baseUrl = Config.API_HOST;
  }

  var httpClient = HttpClient();

  try{
    var uri = new Uri.https(baseUrl, path, params);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    if(response.statusCode == HttpStatus.ok){
      var jsonData = await response.transform(Utf8Decoder()).join();
      callback(jsonData);
    }else{
      errorback('服务器异常');
    }
  }catch(e){
    print(e);
    errorback('解析异常');
  }
}

//全局Post请求
requestPost({String baseUrl, String path, Map<String, String> params, callback, errorback}) async{

  if(baseUrl == null){
    baseUrl = Config.API_HOST;
  }

  var httpClient = HttpClient();

  try{
    var uri = new Uri.https(baseUrl, path, params);
    var request = await httpClient.postUrl(uri);
    var response = await request.close();

    if(response.statusCode == HttpStatus.ok){
      var jsonData = await response.transform(Utf8Decoder()).join();
      callback(jsonData);
    }else{
      errorback('服务器异常');
    }
  }catch(e){
    print(e);
    errorback('解析异常');
  }
}