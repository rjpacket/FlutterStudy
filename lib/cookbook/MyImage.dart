import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my-drawer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Image'),
        ),
        body: FadeInImage.assetNetwork(
            placeholder: 'assets/bg_sky.jpg',
            image: 'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
        )
      ),
    );
  }
}
