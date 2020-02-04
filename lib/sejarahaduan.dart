import 'package:flutter/material.dart';

class SejarahAduan extends StatefulWidget {
  @override
  _SejarahAduanState createState() => _SejarahAduanState();
}

class _SejarahAduanState extends State<SejarahAduan>
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
    // return DefaultTabController(
    //   length: 2,
    //       child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Example App'),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             text: "Home",
    //             icon: Icon(Icons.home),
    //           ),
    //           Tab(
    //             text: "Example page",
    //             icon: Icon(Icons.help),
    //           )
    //         ],
    //       ),
    //     ),

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
        body: TabBarView(
          children: <Widget>[
            Disemak(),
            Selesai(),
            TidakSelesai(),
          ],
          controller: _tabController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.control_point),
        onPressed: () {
          _tabController.animateTo(1,
              curve: Curves.bounceInOut, duration: Duration(milliseconds: 10));

          // _scrollViewController.animateTo(
          //     _scrollViewController.position.minScrollExtent,
          //     duration: Duration(milliseconds: 1000),
          //     curve: Curves.decelerate);

          _scrollViewController
              .jumpTo(_scrollViewController.position.maxScrollExtent);
        },
      ),
    );
  }
}

class Disemak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: Text(
                  'R01-Makmal Pengaturcaraan',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('Komputer rosak'),
              ),
            ],
          ),
        ),
        onTap: () {
          print('data aduan');
        },
      ),
    );
  }
}

class Selesai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              title: Text(
                'R01-Makmal Pengaturcaraan',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Komputer rosak'),
            ),
          ],
        ),
      ),
    );
  }
}

class TidakSelesai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              title: Text(
                'R01-Makmal Pengaturcaraan',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Komputer rosak'),
            ),
          ],
        ),
      ),
    );
  }
}
