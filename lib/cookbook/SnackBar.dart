import 'package:flutter/material.dart';

void main() => runApp(SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snack Bar',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Snack Bar 2'),
        ),
        body: SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('show snack bar'),
        onPressed: () {
          final snackbar = SnackBar(
            content: Text('我被显示出来了'),
            action: SnackBarAction(
                label: 'DELETE',
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                }),
          );

          Scaffold.of(context).showSnackBar(snackbar);
        },
      ),
    );
  }
}
