import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my-http',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  State createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _initCounter();
  }

  _initCounter() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _count = sp.getInt('count') ?? 0;
    });
  }

  _add() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _count++;
      sp.setInt('count', _count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my-home-page'),
      ),
      body: Center(
        child: Text('您按的次数为：$_count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: Icon(Icons.add),
      ),
    );
  }
}
