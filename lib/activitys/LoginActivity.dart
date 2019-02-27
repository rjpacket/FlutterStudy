import 'package:flutter/material.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class LoginActivity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LoginActivityState();
  }
}

class LoginActivityState extends State<LoginActivity>{
  TextEditingController nameController;
  TextEditingController passwordController;


  @override
  void initState() {

    nameController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseActivity(
      topBar: TopBar(
        title: 'Activity切换动画',
      ),
      page: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: '请输入用户名',
                      border: InputBorder.none,
                    ),
                    onChanged: (text) {
                      setState(() {

                      });
                    },
                  ),
                ),
                Text(
                  '发送验证码',
                  style: Styles.normalText,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: '请输入密码',
                border: InputBorder.none,
              ),
              onChanged: (text) {
                setState(() {

                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colours.main_color,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                '登录',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}