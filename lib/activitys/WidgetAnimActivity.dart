import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/TopBar.dart';

class WidgetAnimActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WidgetAnimActivityState();
  }
}

class WidgetAnimActivityState extends State<WidgetAnimActivity>
    with TickerProviderStateMixin {
  AnimationController controller;
  ScrollController scrollController;
  Animation animation;
  double startY;
  double endY;
  double scrollY = 0.0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseActivity(
      topBar: TopBar(
        title: '下拉刷新',
      ),
      page: RefreshLayout(
        child: Column(
          children: <Widget>[
            Container(
              height: 600,
              color: Colors.grey,
            ),
            Container(
              height: 600,
              color: Colors.blueGrey,
            ),
          ],
        ),
        onRefresh: () {},
      ),
    );
  }
}

class RefreshLayout extends StatefulWidget {
  Widget child;

  var onRefresh;

  RefreshLayout({Key key, this.child, this.onRefresh}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RefreshLayoutState();
  }
}

class RefreshLayoutState extends State<RefreshLayout>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  double headerHeight = 100;
  double headerTopHeight = 1000;
  double dy;
  double scrollY = 0;
  double moveY = 0;
  String refreshTitle = '下拉刷新...';

  @override
  void initState() {

    scrollY = headerHeight + headerTopHeight;
    scrollController = ScrollController(initialScrollOffset: scrollY);
    scrollController.addListener(() {
      scrollY = scrollController.offset;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Listener(
      child: Container(
        margin: EdgeInsets.only(top: 0),
        child: ListView.separated(
          controller: scrollController,
          itemCount: 20,
          separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.white,
              ),
          itemBuilder: getView,
        ),
      ),
      onPointerDown: pointDown,
      onPointerMove: pointMove,
      onPointerUp: pointUp,
    );
  }

  pointDown(PointerDownEvent event) {
    dy = event.position.dy;
  }

  pointMove(PointerMoveEvent event) {
    if (event.position.dy - dy > 0) {
      moveY = event.position.dy - dy;
    }
    setState(() {
      if(scrollY < headerTopHeight){
        refreshTitle = '释放可刷新...';
      }else if(scrollY < headerTopHeight + headerHeight){
        refreshTitle = '下拉刷新...';
      }
    });
  }

  pointUp(PointerUpEvent event) {
    if (scrollY < headerTopHeight) {
      //可以刷新
      setState(() {
        refreshTitle = '正在刷新...';
      });
      scrollY = headerTopHeight;
      startAnim();
    }else if(scrollY < headerHeight + headerTopHeight){
      //不足以刷新的位置
      finishLoading();
    }
  }

  startAnim() async{
    if (scrollController != null && scrollController.hasClients) {
      scrollController.animateTo(
        scrollY,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 200),
      );
    }
    widget.onRefresh();

    await  Future.delayed(const Duration(seconds: 3));
    finishLoading();
  }

  finishLoading() {
    scrollY = headerHeight + headerTopHeight;
    if (scrollController != null && scrollController.hasClients) {
      scrollController.animateTo(
        scrollY,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  Widget getView(BuildContext context, int index) {
    if (index == 0) {
      return Container(
        height: headerHeight + headerTopHeight,
        child: Column(
          children: <Widget>[
            Container(
              height: headerTopHeight,
              child: Center(
                child: Text(
                  '第二楼',
                  style: Styles.normalText,
                ),
              ),
            ),
            Container(
              height: headerHeight,
              child: Center(
                child: Text(
                  refreshTitle,
                  style: Styles.normalText,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      if (index % 2 == 0) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.grey,
          height: 200,
        );
      } else {
        return Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.blueGrey,
          height: 200,
        );
      }
    }
  }
}
