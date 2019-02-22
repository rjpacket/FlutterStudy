import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/res/events.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/TopBar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HttpActivity extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HttpActivityState();
  }
}

class HttpActivityState extends State<HttpActivity>{
  List<Map<String, String>> showData = [];
  bool showLoading = false;

  @override
  void initState() {
    super.initState();

//    requestData();

    var path = '/satinGodApi';
    Map<String, String> params = {
      'type': '1',
      'page': '1',
    };

    setState(() {
      showLoading = true;
    });
    requestGet(path: path, params: params, callback: (data) {
      var result = json.decode(data);
      print(result);
      for (var value in result['data']) {
        showData.add({
          'text': value['text'],
          'header': value['header'],
          'thumbnail': value['thumbnail'],
          'username': value['username'],
          'passtime': value['passtime'],
        });
      }

      setState(() {
        showLoading = false;
      });
    }, errorback: (error) {

    });
  }



  requestData() async{
    var url = 'https://www.apiopen.top/satinGodApi?type=1&page=1';
    var httpClient = HttpClient();

    var result;
    try{
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();

      if(response.statusCode == HttpStatus.ok){
        var jsonData = await response.transform(Utf8Decoder()).join();
        result = json.decode(jsonData);
        print(result);
        for (var value in result['data']) {
          showData.add({
            'text': value['text'],
            'header': value['header'],
            'thumbnail': value['thumbnail'],
            'username': value['username'],
            'passtime': value['passtime'],
          });
        }
      }
    }catch(e){
      print(e);
    }

    if (!mounted) return;

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return BaseActivity(
      showLoading: showLoading,
      topBar: TopBar(
        title: 'Http请求',
      ),
      page: Container(
        color: Color.fromARGB(255, 244, 245, 246),
        child: ListView.builder(
          itemCount: showData.length,
          itemBuilder: _buildListView,
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    var item = showData[index];

    String headerUrl = item['header'];
    if(headerUrl == null){
      headerUrl = 'http://wimg.spriteapp.cn/profile/large/2018/04/17/5ad580d81b321_mini.jpg';
    }

    String thumbnail = item['thumbnail'];
    if(thumbnail == null){
      thumbnail = 'http://wimg.spriteapp.cn/picture/2017/1019/6807afda-b4e5-11e7-8352-1866daeb0df1_wpd_79.jpg';
    }

    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(headerUrl),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 15)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item['username'] == null ? ' ' : item['username'],
                    style: Styles.normalText,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    item['passtime'] == null ? ' ' : item['passtime'],
                    style: Styles.normalText,
                  ),
                ],
              )
            ],
          ),

          Padding(padding: EdgeInsets.only(top: 10)),

          Text(
            item['text'] == null ? ' ' : item['text'],
            style: Styles.normalText,
          ),

          Padding(padding: EdgeInsets.only(top: 10)),

          Offstage(
            offstage: thumbnail == null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: thumbnail,
                errorWidget: Icon(Icons.error),
                height: 200,
                width: ScreenUtil.getScreenWidth(context) - 60,
                fit: BoxFit.cover,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
