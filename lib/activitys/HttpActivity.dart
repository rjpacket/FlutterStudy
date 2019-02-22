import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/res/events.dart';
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
  List<Map<String, String>> showData = [];

  @override
  void initState() {
    super.initState();

//    requestData();

    var path = '/satinGodApi';
    Map<String, String> params = {
      'type': '1',
      'page': '1',
    };

    requestGet(path: path, params: params, callback: (data) {
      var result = json.decode(data);
      print(result);
      for (var value in result['data']) {
        showData.add({
          'text': value['text']
        });
      }

      setState(() {

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
        itemCount: showData.length,
        itemBuilder: _buildListView,
      ),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    var item = showData[index];
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
