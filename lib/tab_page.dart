import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
//import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  int counter = 0;
  bool checkTick = false;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List list = ["item 1", "item 2", "item 3"];
    return Scaffold(
        appBar: AppBar(
          title: Text("appBar"),
        ),
        body: Text("dsfdf"));
  }
}
