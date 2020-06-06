import 'dart:convert';

import 'package:eaduanfsktm/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class Disemak extends StatelessWidget {
  Future<List> lihatAduan() async {
    final response = await http.get(BaseUrl.lihataduandisemak());
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: lihatAduan(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new ItemList(list: snapshot.data)
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class Selesai extends StatelessWidget {
  Future<List> lihatAduan() async {
    final response = await http.get(BaseUrl.lihataduanselesai());
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: lihatAduan(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new ItemList(list: snapshot.data)
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class TidakSelesai extends StatelessWidget {
  Future<List> lihatAduan() async {
    final response = await http.get(BaseUrl.lihataduantidakselesai());
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: lihatAduan(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new ItemList(list: snapshot.data)
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(1.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new Details(
                  list: list,
                  index: i,
                ),
              ),
            ),
            child: new Card(
              child: new ListTile(
                title: Text(
                  '${list[i]['tarikhaduan']}',
                  // new DateFormat("dd-MM-yyyy").format(list[i]['tarikhaduan']),

                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${list[i]['namafasiliti']} -> ${list[i]['namaruang']} ',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new Details(list: list, index: i),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Details extends StatefulWidget {
  final List list;
  final index;

  Details({this.list, this.index});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title:
            new Text("${widget.list[widget.index]['namaruang']}".toUpperCase()),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(
                widget.list[widget.index]['namaruang'],
                style: new TextStyle(fontSize: 20.0),
              ),
              new Text(
                widget.list[widget.index]['namafasiliti'],
                style: new TextStyle(fontSize: 20.0),
              ),
              new Text(
                widget.list[widget.index]['status'],
                style: new TextStyle(fontSize: 20.0),
              ),

              // new Row(
              //   mainAxisAlignment: MainAxisAlignment.center  ,
              //   children: <Widget>[

              //     RaisedButton(
              //       child: Text("EDIT"),
              //       color: Colors.green,
              //       onPressed: ()=> Navigator.of(context).push(
              //         new MaterialPageRoute(
              //           builder: (BuildContext context)=>new EditData(list:widget.list,index:widget.index),
              //         )
              //       ),
              //     ),
              //     RaisedButton(
              //       child: Text("DELETE"),
              //       color: Colors.red,
              //       onPressed: ()=> confirm(),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
