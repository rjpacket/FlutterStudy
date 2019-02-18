import 'package:flutter/material.dart';
import 'package:flutter_app/res/Config.dart';

//默认设计稿的宽高
double designWidth = Config.DESIGN_WIDTH;
double designHeight = Config.DESIGN_HEIGHT;
double designDensity = Config.DESIGN_DENSITY;

//在app设置设计稿的尺寸
void setDesignWithAndHeight(double width, double height, {double density: Config.DESIGN_DENSITY}){
  designWidth = width;
  designHeight = height;
  designDensity = density;
}

class ScreenUtil{

  //获取屏幕宽度
  static double getScreenWidth(BuildContext context){
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.width;
  }

  //获取屏幕高度
  static double getScreenHeight(BuildContext context){
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.size.height;
  }

  //获取屏幕密度
  static double getScreenDensity(BuildContext context){
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.devicePixelRatio;
  }

  //获取状态栏的高度
  static double getStatusBarHeight(BuildContext context){
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return mediaQueryData.padding.top;
  }

  //按宽度返回适配的尺寸
  static double getAdaptWidth(BuildContext context, double size){
    if(context == null || getScreenWidth(context) == 0){
      return size;
    }
    return size * getScreenWidth(context) / designWidth;
  }

  //按高度返回适配的尺寸
  static double getAdaptHeight(BuildContext context, double size){
    if(context == null || getScreenHeight(context) == 0){
      return size;
    }
    return size * getScreenHeight(context) / designHeight;
  }

  //按屏幕密度适配的字体大小
  static double getAdaptSp(BuildContext context, double fontSize, {bool followSystem: true}){
    if(context == null || getScreenDensity(context) == 0){
      return fontSize;
    }
    return (followSystem ? MediaQuery.of(context).textScaleFactor : 1.0) * fontSize * getScreenDensity(context) / designDensity;
  }
}