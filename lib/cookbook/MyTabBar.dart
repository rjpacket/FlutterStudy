import 'package:flutter/material.dart';

void main() => runApp(MyTabBarDemo());

class MyTabBarDemo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my-tab-bar-demo',
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('MyTabBarDemo'),
              bottom: TabBar(
                  tabs: [
                    Tab(text: '汽车',icon: Icon(Icons.directions_car)),
                    Tab(text: '骑车',icon: Icon(Icons.directions_bike)),
                    Tab(text: '火车',icon: Icon(Icons.directions_transit)),
                  ]
              ),
            ),
            body: TabBarView(
                children: [
                  Icon(Icons.directions_car),
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_transit),
                ]
            ),
          ),
      ),
    );
  }
}