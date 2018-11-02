import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = List <String>.generate(30,(i)=>'Item$i');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my-drawer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My ListView'),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Dismissible(
                  key: Key(item),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('delete one')));
                  },
                  background: Container(color: Colors.redAccent),
                  child: GestureDetector(
                    onTap: () {
                      _getResult(context, item);
                    },
                    child: Hero(
                        tag: item,
                        child: Container(
                          height: 100.0,
                          child: Image.network('https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg'),
                        ),
                    ),
                  )
              );
            }
        ),
      ),
    );
  }

  void _getResult(BuildContext context, String item) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(title: item,)));

    Scaffold.of(context).showSnackBar(SnackBar(content: Text(result)));
  }
}

class DetailPage extends StatefulWidget{
  final String title;

  DetailPage({Key key, this.title}) : super(key: key);

  @override
  State createState() {
    return DetailPageState(title);
  }
}

class DetailPageState extends State<DetailPage> {

  final String title;
  bool _visible = true;

  DetailPageState(this.title);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '第二页',
      home: Scaffold(
        appBar: AppBar(
          title: Text('second page'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _visible = !_visible;
              });
            },
            child: AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
              child: Hero(
                tag: title,
                child: Center(
                  child: Container(
                    height: 500.0,
                    width: 500.0,
                    child: Image.network(
                      'https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
