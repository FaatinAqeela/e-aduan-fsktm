import 'package:flutter/material.dart';

import 'sejarahaduan.dart';

class SenaraiAduan extends StatefulWidget {
  @override
  _SenaraiAduanState createState() => _SenaraiAduanState();
}

class _SenaraiAduanState extends State<SenaraiAduan>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Sejarah Aduan'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    text: "Disemak",
                    icon: Icon(Icons.query_builder),
                  ),
                  Tab(
                    text: "Selesai",
                    icon: Icon(Icons.done),
                  ),
                  Tab(
                    text: "Tidak Selesai",
                    icon: Icon(Icons.help),
                  )
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              Disemak(),
              Selesai(),
              TidakSelesai(),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
