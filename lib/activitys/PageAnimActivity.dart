import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class PageAnimActivity extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BaseActivity(
      topBar: TopBar(
        title: 'Activity切换动画',
      ),
      page: Center(
        child: Text(
          '页面动画',
          style: Styles.normalText,
        ),
      ),
    );
  }
}