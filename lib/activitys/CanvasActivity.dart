import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class MyCircle extends CustomPainter{
  double progress;

  MyCircle({this.progress: 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint();
    p.color = Colors.greenAccent;
    p.isAntiAlias = true;
    p.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 4, size.height / 4), size.width / 2 * progress, p);
    canvas.drawCircle(Offset(size.width / 4, size.height * 3 / 4), size.width / 2 * progress, p);
    canvas.drawCircle(size.center(Offset(0, 0)), size.width / 2 * progress, p);
    canvas.drawCircle(Offset(size.width * 3 / 4, size.height / 4), size.width / 2 * progress, p);
    canvas.drawCircle(Offset(size.width * 3 / 4, size.height * 3 / 4), size.width / 2 * progress, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class CanvasActivity extends StatefulWidget{

  @override
  State createState() {
    return CanvasActivityState();
  }
}

class CanvasActivityState extends State<CanvasActivity> with TickerProviderStateMixin{
  double progress;
  AnimationController ac;

  @override
  void initState() {
    super.initState();

    ac = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 10000)
    );
    ac.addListener(() {
      this.setState(() {
        this.progress = ac.value;
      });
    });
    ac.forward();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseActivity(
      topBar: TopBar(
        title: 'Canvas绘制',
      ),
      page: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: CustomPaint(
          painter: MyCircle(progress: progress),
        ),
      ),
    );
  }
}