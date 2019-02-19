import 'package:flutter/material.dart';
import 'package:flutter_app/res/Config.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class BaseActivity extends StatelessWidget{
  final Widget topBar;
  final Widget page;

  const BaseActivity({Key key, this.page, this.topBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalHeight = ScreenUtil.getStatusBarHeight(context) + ScreenUtil.getAdaptWidth(context, Config.TOP_BAR_HEIGHT);
    return Scaffold(
      appBar: PreferredSize(
        child: topBar,
        preferredSize: Size(ScreenUtil.getScreenWidth(context), totalHeight),
      ),
      body: page,
    );
  }
}