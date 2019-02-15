import 'package:flutter/material.dart';

class PopupWindow extends StatelessWidget{
  final bool isHidePopup;
  final Widget child;
  final bool isCoverShow;
  final double width;
  final double height;
  final double left;
  final double top;
  Decoration decoration;

  PopupWindow({
    Key key,
    this.isHidePopup: false,
    this.child,
    this.isCoverShow: true,
    this.width,
    this.height,
    this.left,
    this.top,
    this.decoration
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int transparentDu = 0;
    if(isCoverShow){
      transparentDu = 102;
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double right = 0;
    double bottom = 0;

    if(left + width <= screenWidth){
      right = screenWidth - left - width;
    }

    if(top + height <= screenHeight){
      bottom = screenHeight - top - height;
    }

    if(decoration == null){
      decoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      );
    }

    return Offstage(
      offstage: isHidePopup,
      child: Container(
        width: screenWidth,
        height: screenHeight,
        color: Color.fromARGB(transparentDu, 0, 0, 0),
        child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
          decoration: decoration,
          padding: EdgeInsets.all(10),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}