import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/PopupWindow.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app/widgets/TopBar.dart';
import 'package:flutter_app/widgets/TabLayout.dart';

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

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'My Page Title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          new Expanded(
              child: new ShopList(products: <Product>[
            new Product(name: 'Android'),
            new Product(name: 'IOS'),
            new Product(name: 'H5')
          ]))
        ],
      ),
    );
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
  runApp(new MaterialApp(
    title: 'My App',
    home: new DemoPage(),
  ));
}

class FirstScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FirstScreenState();
  }
}

class FirstScreenState extends State<FirstScreen> {
  bool isHidePopup = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('第一页内容'),
      ),
      body: Stack(
        children: <Widget>[
          new Center(
            child: new RaisedButton(
                child: new Text('跳转第二页'),
                onPressed: () {
//              Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) => new SecondScreen()));

                }),
          ),

        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('第二页内容'),
      ),
      body: new Center(
        child: new RaisedButton(
            child: new Text('第二页'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}

class DemoPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return DemoPageState();
  }
}

class DemoPageState extends State<DemoPage> with SingleTickerProviderStateMixin{
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

    return Stack(
      children: <Widget>[
        _buildPage(),

        PopupWindow(
          width: 100,
          height: 240,
          left: 100,
          top: 100,
          child: Column(
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
          ),
        ),
      ],
    );
  }

  Widget _buildUserLabel() {
    return Container(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(left: 20.0)),
              Image(
                width: 50.0,
                  height: 50.0,
                  image: AssetImage('assets/default_user_head.png')
              ),
              Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        '3年级6班',
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                          decoration: TextDecoration.none
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '老师8',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),
                          ),
                          Text(
                            '学生23',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),
                          ),
                          Text(
                            '财富8',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),
                          ),
                          Text(
                            '动态12',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                decoration: TextDecoration.none
                            ),
                          ),
                        ],
                      )
                    ],
                  )
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Container(
            height: 30.0,
            child: Text(
              '公告：下午四点小王子话剧彩排',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  decoration: TextDecoration.none
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _bulidTab() {
    return Container(
      color: Colors.white,
      height: 42.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(left: 5.0)),
          Text(
            '作业列表',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.blue,
                decoration: TextDecoration.none
            ),
          ),
          Text(
            '完成率',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                decoration: TextDecoration.none
            ),
          ),
          Text(
            '错题本',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                decoration: TextDecoration.none
            ),
          ),
          Text(
            '排行榜',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                decoration: TextDecoration.none
            ),
          ),
          Padding(padding: const EdgeInsets.only(right: 5.0))
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        children: <Widget>[
          Text(
            '语文口语专项训练',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                decoration: TextDecoration.none
            ),
          ),
          Text(
            '9月28日 星期三',
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
                decoration: TextDecoration.none
            ),
          ),
          Row(
            children: <Widget>[
//                LinearProgressIndicator(
//                  backgroundColor: Colors.grey,
//                  value: 50,
//                ),
              Text(
                '完成人数 50/100',
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    decoration: TextDecoration.none
                ),
              ),
            ],
          )
        ],
      ),
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
          MyPage(),
          FirstScreen(),
          SecondScreen(),
        ],
        controller: _tabController,
      ),
    );
  }
}
