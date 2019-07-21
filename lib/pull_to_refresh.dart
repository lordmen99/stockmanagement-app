import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefresh extends StatelessWidget {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: defaultHeader,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          print("fgfgf");
          _refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: <Widget>[
//            RefreshBackground(),
            SliverList(delegate: SliverChildListDelegate(buildList())),
          ],
        ),
      ),
    );
  }
}

List<Widget> buildList() {
  return List.generate(
      15,
      (index) => Container(
            height: 100,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ));
}

