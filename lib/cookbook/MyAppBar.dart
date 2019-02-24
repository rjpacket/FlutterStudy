import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/activitys/CanvasActivity.dart';
import 'package:flutter_app/activitys/EventBusActivity.dart';
import 'package:flutter_app/activitys/HttpActivity.dart';
import 'package:flutter_app/activitys/PageAnimActivity.dart';
import 'package:flutter_app/res/colors.dart';
import 'package:flutter_app/res/events.dart';
import 'package:flutter_app/res/strings.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/utils/ScreenUtil.dart';
import 'package:flutter_app/widgets/BaseActivity.dart';
import 'package:flutter_app/widgets/PopupWindow.dart';
import 'package:flutter_app/widgets/SettingItem.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app/widgets/TopBar.dart';
import 'package:flutter_app/widgets/TabLayout.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      child: new Row(
        children: <Widget>[
          new IconButton(icon: new Icon(Icons.menu), onPressed: null),
          new Expanded(child: title),
          new IconButton(icon: new Icon(Icons.search), onPressed: null)
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    double bannerWidth = ScreenUtil.getScreenWidth(context);
    double bannerHeight = bannerWidth * 9 / 16;
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        //banner
        Container(
          height: bannerHeight,
          child: Swiper(
            itemHeight: bannerHeight,
            itemWidth: bannerWidth,
            itemBuilder: _swiperBuilder,
            itemCount: 3,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                size: 6,
                activeSize: 6,
                color: Colors.black54,
                activeColor: Colors.white,
              ),
            ),
            controller: SwiperController(),
            scrollDirection: Axis.horizontal,
            autoplay: true,
            onTap: (index) => print('点击了$index'),
          ),
        ),
      ],
    );
  }

  Widget _swiperBuilder(BuildContext context, int index){
    if(index == 0){
      return Image.network(
        Strings.banner_1,
        fit: BoxFit.fill,
      );
    }else if(index == 1){
      return Image.network(
        Strings.banner_2,
        fit: BoxFit.fill,
      );
    }else{
      return Image.network(
        Strings.banner_3,
        fit: BoxFit.fill,
      );
    }
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class Product {
  Product({this.name});

  String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged});

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return new TextStyle(
        color: Colors.black54, decoration: TextDecoration.underline);
  }
}

class ShopList extends StatefulWidget {
  ShopList({this.products});

  final List<Product> products;

  @override
  State<StatefulWidget> createState() {
    return new ShopListState();
  }
}

class ShopListState extends State<ShopList> {
  Set<Product> _selectedProducts = new Set<Product>();

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      children: widget.products.map((Product product) {
        return new ShoppingListItem(
          product: product,
          inCart: _selectedProducts.contains(product),
          onCartChanged: _clickProduct,
        );
      }).toList(),
    );
  }

  void _clickProduct(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _selectedProducts.add(product);
      } else {
        _selectedProducts.remove(product);
      }
    });
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class CounterDisplay extends StatelessWidget {
  final int count;

  CounterDisplay({this.count});

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterAdd extends StatelessWidget {
  final VoidCallback onPressed;

  CounterAdd({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Add'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CounterState();
  }
}

class CounterState extends State<Counter> {
  int _count = 0;

  void _add() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new CounterAdd(
          onPressed: _add,
        ),
        new CounterDisplay(
          count: _count,
        )
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MainActivity(),
  ));
}

class FindPage extends StatefulWidget{
  final callback;

  const FindPage({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FindPageState();
  }
}

class FindPageState extends State<FindPage> {

  double downY = 0;
  double dy = 0;

  ScrollController scrollController = ScrollController(initialScrollOffset: 200, keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: _dragStart,
      onVerticalDragUpdate: _dragUpdate,
      onVerticalDragEnd: _dragEnd,
      child: ListView(
        padding: EdgeInsets.all(0),
        controller: scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.redAccent,
          ),
          Container(
            height: 300,
            color: Colors.blueAccent,
          )
        ],
      ),
    );
  }

  void _dragStart(DragStartDetails details) {
    downY = details.globalPosition.dy;
  }

  void _dragUpdate(DragUpdateDetails details) {
    setState(() {
      dy = details.globalPosition.dy - downY;
    });
  }

  void _dragEnd(DragEndDetails details) {

  }
}

class MinePage extends StatefulWidget{
  final callback;

  MinePage({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MinePageState();
  }
}

class MinePageState extends State<MinePage> {
  String title = '我的';

  @override
  void initState() {
    super.initState();

    //监听EventBus的消息
    eventBus.on<EventBusEvent>().listen((event) {
      setState(() {
        title = event.title;
      });
    });
    //下面写法可以控制是否监听
//    StreamSubscription subscription = eventBus.on<EventBusEvent>().listen((event) {
//      setState(() {
//        title = event.title;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    print('我的页面构建......');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: ListView(
        children: <Widget>[
          SettingItem(
            icon: 'assets/images/nav_01.png',
            settingTitle: Strings.mine_pay,
            callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventBusActivity()));
            },
          ),
          Divider(height: 1,),
          SettingItem(
            icon: 'assets/images/nav_02.png',
            settingTitle: Strings.mine_save,
            callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CanvasActivity()));
            },
          ),
          Divider(height: 1,),
          SettingItem(
            icon: 'assets/images/nav_03.png',
            settingTitle: Strings.mine_album,
            callback: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, anim1, anim2) => PageAnimActivity(),
                transitionsBuilder: (context, anim1, anim2, child) => SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset(0.0, 0.0),
                  ).animate(anim1),
                  child: child,
                ),
              ));
            },
          ),
          Divider(height: 1,),
          SettingItem(
            icon: 'assets/images/nav_04.png',
            settingTitle: Strings.mine_card,
            callback: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HttpActivity()));
            },
          ),
          Divider(height: 1,),
          SettingItem(
            icon: 'assets/images/nav_05.png',
            settingTitle: Strings.mine_face,
          ),
          Divider(height: 1,),
          SettingItem(
            icon: 'assets/images/nav_01.png',
            settingTitle: Strings.mine_setting,
          ),
        ],
      ),
    );
  }
}

class MainActivity extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return MainActivityState();
  }
}

class MainActivityState extends State<MainActivity> with SingleTickerProviderStateMixin{
  final List<String> tabs = ['首页', '发现', '我的'];
  final List<Image> selectedIcons = [
    Image.asset('assets/images/nav_01.png', width: 20, height: 20,),
    Image.asset('assets/images/nav_03.png', width: 20, height: 20,),
    Image.asset('assets/images/nav_05.png', width: 20, height: 20,),
  ];
  final List<Image> unSelectedIcons = [
    Image.asset('assets/images/nav_02.png', width: 20, height: 20,),
    Image.asset('assets/images/nav_04.png', width: 20, height: 20,),
    Image.asset('assets/images/nav_06.png', width: 20, height: 20,),
  ];

  TabController _tabController;
  int selectedIndex = 1;
  bool isHidePopup = true;
  Widget popupChild;
  double popupWidth = 0;
  double popupHeight = 0;
  double popupLeft = 0;
  double popupTop = 0;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(vsync: this, initialIndex: selectedIndex, length: tabs.length);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Stack(
          children: <Widget>[
            _buildPage(),

            PopupWindow(
              width: popupWidth,
              height: popupHeight,
              left: popupLeft,
              top: popupTop,
              isHidePopup: isHidePopup,
              child: (popupChild == null ? Divider() : popupChild),
            ),


          ],
        ),
        onWillPop: () {
          if(!isHidePopup){
            setState(() {
              isHidePopup = true;
            });
          }
        }
    );
  }

  Widget _buildPage() {
    return Scaffold(
//      appBar: PreferredSize(
//          child: TopBar(
//            title: '',
//            backgroundColor: Colors.blue,
//            rightIcon: Icon(
//              Icons.more_vert,
//              color: Colors.white,
//            ),
//          ),
//          preferredSize: null
//      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(
          child: TabLayout(
            titles: tabs,
            selectedIcons: selectedIcons,
            unSelectedIcons: unSelectedIcons,
            controller: _tabController,
            isShowIndicator: false,
            selectedIndex: selectedIndex,
          ),
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          HomePage(),
          FindPage(callback: () {
           setState(() {
             popupWidth = ScreenUtil.getScreenWidth(context);
             popupHeight = 200;
             popupLeft = 0;
             popupTop = ScreenUtil.getScreenHeight(context) - 200;
             popupChild = Column(
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                 Container(
                   height: 40,
                   child: Center(
                     child: Text(
                       '删除',
                       style: TextStyle(
                           fontSize: 14,
                           color: Colors.redAccent,
                           decoration: TextDecoration.none
                       ),
                     ),
                   ),
                 ),
                 Container(
                   height: 40,
                   child: Center(
                     child: Text(
                       '撤回',
                       style: TextStyle(
                           fontSize: 14,
                           color: Colors.redAccent,
                           decoration: TextDecoration.none
                       ),
                     ),
                   ),
                 ),
                 Container(
                   height: 40,
                   child: Center(
                     child: Text(
                       '取消',
                       style: TextStyle(
                           fontSize: 14,
                           color: Colors.blueAccent,
                           decoration: TextDecoration.none
                       ),
                     ),
                   ),
                 ),
                 Container(
                   height: 40,
                   child: Center(
                     child: Text(
                       '确认',
                       style: TextStyle(
                           fontSize: 14,
                           color: Colors.blueAccent,
                           decoration: TextDecoration.none
                       ),
                     ),
                   ),
                 )
               ],
             );
             isHidePopup = false;

           });
          }),
          MinePage(callback: (offset) {
            setState(() {
              popupWidth = 100;
              popupHeight = 200;
              popupLeft = offset.dx;
              popupTop = offset.dy;
              popupChild = Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        '删除',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        '撤回',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        '取消',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        '确认',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  )
                ],
              );
              isHidePopup = false;
            });
          },),
        ],
        controller: _tabController,
      ),
    );
  }
}
