import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

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

class FileStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    return file.writeAsString('$counter');
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
  var storage = FileStorage();
  final myController = TextEditingController();
  final focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initCounter();

    myController.addListener(_textChange);
  }

  _textChange() {
//    setState(() {
//      myController.text = '123';
//    });
  }

  @override
  void dispose() {
    myController.removeListener(_textChange);

    focusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  _initCounter() async {
    storage.readCounter().then((int value) {
      setState(() {
        _count = value;
      });
    });
  }

  _add() async {
    setState(() {
      _count++;
    });

    return storage.writeCounter(_count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my-home-page'),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('您按的次数为：$_count'),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter a search term'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please input something';
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your username'),
                  controller: myController,
                  focusNode: focusNode,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          showDialog(
//            context: context,
//            builder: (context) {
//              return AlertDialog(
//                content: Text(myController.text),
//              );
//            },
//          );

//          FocusScope.of(context).requestFocus(focusNode);

          if (_formKey.currentState.validate()) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('验证通过')));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
