import 'package:flutter/material.dart';
import 'package:flutter_app/res/events.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class EventBusActivity extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BaseActivity(
      topBar: TopBar(
        title: 'EventBus传值',
      ),
      page: Center(
        child: RaisedButton(
          onPressed: () {
            //发送一个EventBus消息
            eventBus.fire(EventBusEvent('来自EventBus'));

            Navigator.of(context).pop();
          },
          child: Text(
            '修改上一页的标题为“来自EventBus”',
            style: Styles.normalText,
          ),
        ),
      ),
    );
  }
}