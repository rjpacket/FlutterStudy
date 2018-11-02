import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my-drawer',
      home: Scaffold(
          appBar: AppBar(
            title: Text('My ListView'),
          ),
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(100, (index) {
              return Container(
                height: 40.0,
                child: Center(
                  child: Text('Item $index'),
                ),
              );
            }),
          )),
    );
  }
}
