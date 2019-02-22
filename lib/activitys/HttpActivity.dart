import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class HttpActivity extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HttpActivityState();
  }
}

class HttpActivityState extends State<HttpActivity>{
  List<Map<String, String>> data = [];

  @override
  void initState() {
    super.initState();

    requestData();
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
          data.add({
            'text': value['text']
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
      topBar: TopBar(
        title: 'Http请求',
      ),
      page: ListView.builder(
        itemCount: data.length,
        itemBuilder: _buildListView,
      ),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    var item = data[index];
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
      child: Text(
        item['text'],
        style: Styles.normalText,
      ),
    );
  }
}

class Joke{
  String type;
  String text;
  String username;
  String uid;
  String header;
  int comment;
  String top_commentsVoiceuri;
  String top_commentsContent;
  String top_commentsHeader;
  String top_commentsName;
  String passtime;
  int soureid;
  int up;
  int down;
  int forward;
  String image;
  String gif;
  String thumbnail;
  String video;

  Joke();
}