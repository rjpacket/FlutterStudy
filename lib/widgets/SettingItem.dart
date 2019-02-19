import 'package:flutter/material.dart';
import 'package:flutter_app/res/colors.dart';

class SettingItem extends StatelessWidget{
  final callback;
  final String icon;
  final String settingTitle;

  const SettingItem({Key key, this.icon, this.settingTitle, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: callback,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              icon,
              width: 20,
              height: 20,
            ),
            Padding(padding: const EdgeInsets.only(left: 20)),
            Expanded(
              child: Text(
                settingTitle,
                style: TextStyle(
                    fontSize: 14,
                    color: Colours.text_black,
                    decoration: TextDecoration.none
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}