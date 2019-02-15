import 'package:flutter/material.dart';

class TabLayout extends StatefulWidget{
  final List<String> titles;
  final List<Image> selectedIcons;
  final List<Image> unSelectedIcons;
  final TabController controller;
  final Color selectedColor;
  final Color unSelectedColor;
  final double selectedTextSize;
  final double unSelectedTextSize;
  final double iconWidth;
  final double iconHeight;
  final double iconTextSpace;
  final double tabPaddingTop;
  final bool isScrollable;
  final bool isShowIndicator;
  final Decoration indicator;
  final int selectedIndex;

  TabLayout({
    Key key,
    this.titles,
    this.selectedIcons,
    this.unSelectedIcons,
    this.controller,
    this.selectedColor: Colors.redAccent,
    this.unSelectedColor: Colors.black,
    this.selectedTextSize: 12,
    this.unSelectedTextSize: 12,
    this.iconWidth: 20,
    this.iconHeight: 20,
    this.iconTextSpace: 2,
    this.tabPaddingTop: 10,
    this.isScrollable: false,
    this.isShowIndicator: true,
    this.indicator,
    this.selectedIndex
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TabLayoutState();
  }
}

class TabLayoutState extends State<TabLayout> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  TabController _tabControllerSelf;

  @override
  void initState() {
    super.initState();

    _tabControllerSelf = TabController(vsync: this, initialIndex: 0, length: widget.titles.length);
    _tabControllerSelf.addListener(() {
      setState(() {
        selectedIndex = _tabControllerSelf.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [];
    for(var i = 0; i < widget.titles.length; i++){
      tabs.add(_buildSingleTab(i));
    }

    return TabBar(
      isScrollable: widget.isScrollable,
      tabs: tabs,
      controller: widget.controller == null ? _tabControllerSelf : widget.controller,
      indicatorColor: widget.isShowIndicator ? widget.selectedColor : Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      //indicator的高度权重
      indicatorWeight: 2,
      indicator: widget.indicator,
    );
  }

  Widget _buildSingleTab(int index) {
    if(widget.controller != null){
      selectedIndex = widget.selectedIndex;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: widget.tabPaddingTop),
        child: Center(
          child: Column(
            children: <Widget>[
              selectedIndex == index ? widget.selectedIcons[index] : widget.unSelectedIcons[index],
              Padding(padding: EdgeInsets.only(top: widget.iconTextSpace)),
              Text(
                widget.titles[index],
                style: TextStyle(
                    color: selectedIndex == index ? widget.selectedColor : widget.unSelectedColor,
                    fontSize: selectedIndex == index ? widget.selectedTextSize : widget.unSelectedTextSize,
                    decoration: TextDecoration.none
                ),
              )
            ],
          ),
        )
    );
  }
}