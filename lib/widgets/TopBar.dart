import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  final Key key;
  final double height;
  final Color backgroundColor;
  final String title;
  final Widget middle;
  final Widget leftIcon;
  final Widget rightIcon;

  TopBar({this.height: 80.0, this.key, this.backgroundColor: Colors.red, this.title, this.middle, this.leftIcon, this.rightIcon}) : super(key: key);

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
        child: Icon(
            Icons.arrow_back,
          color: Colors.white,
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

    return Container(
      height: widget.height,
      color: widget.backgroundColor,
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          leftIcon,
          middle,
          widget.rightIcon
        ],
      ),
    );
  }
}
