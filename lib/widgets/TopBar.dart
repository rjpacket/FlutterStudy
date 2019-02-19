import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_app/res/Config.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';

class TopBar extends StatefulWidget {
  final Key key;
  final double height;
  final Color backgroundColor;
  final String title;
  final Widget middle;
  final Widget leftIcon;
  final Widget rightIcon;

  TopBar({
    this.height,
    this.key,
    this.backgroundColor: Colours.main_color,
    this.title,
    this.middle,
    this.leftIcon,
    this.rightIcon
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return _buildTopBar();
  }

  Widget _buildTopBar() {
    Widget leftIcon = widget.leftIcon;
    //如果没有设置左边的返回按钮，默认一个icon
    if(leftIcon == null){
      leftIcon = GestureDetector(
        child: Container(
          width: 20,
          height: 20,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      );
    }

    Widget middle = widget.middle;
    if(middle == null){
      String title = widget.title;
      if(title == null){
        title = '标题';
      }
      middle = Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          decoration: TextDecoration.none
        ),
      );
    }

    double statusBarHeight = ScreenUtil.getStatusBarHeight(context);
    double topBarHeight = widget.height;
    if(widget.height == 0 || widget.height == null){
      topBarHeight = statusBarHeight + ScreenUtil.getAdaptWidth(context, Config.TOP_BAR_HEIGHT);
    }

    bool showRight = widget.rightIcon == null;

    return Container(
      height: topBarHeight,
      color: widget.backgroundColor,
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Stack(
        children: <Widget>[
          Container(
            height: topBarHeight,
            padding: EdgeInsets.only(left: Config.TOP_BAR_PADDING_LEFT, right: Config.TOP_BAR_PADDING_RIGHT),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leftIcon,
                Offstage(
                  offstage: showRight,
                  child: widget.rightIcon,
                )
              ],
            ),
          ),
          Center(
            child: middle,
          )
        ],
      ),
    );
  }
}
