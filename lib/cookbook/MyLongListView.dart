import 'package:flutter/material.dart';

void main() => runApp(MyApp(
      items: List<ListItem>.generate(
          100,
          (i) => i % 6 == 0
              ? HeadingItem('Heading $i')
              : MessageItem('Sender $i', 'Message $i')),
    ));

class MyApp extends StatelessWidget {
  final List<ListItem> items;

  MyApp({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my-drawer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Long ListView'),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if(item is HeadingItem){
                return ListTile(
                  title: Text(
                    item.heading,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                );
              }else if(item is MessageItem){
                return ListTile(
                  title: Text(item.sender),
                  subtitle: Text(item.body),
                );
              }
            }),
      ),
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
