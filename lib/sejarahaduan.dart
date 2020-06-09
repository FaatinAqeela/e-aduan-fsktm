import 'dart:convert';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:eaduanfsktm/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class SejarahAduan extends StatefulWidget {
  final String idpengguna;
  SejarahAduan(this.idpengguna);
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
              Disemak(widget.idpengguna),
              Selesai(widget.idpengguna),
              TidakSelesai(widget.idpengguna),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}

class Disemak extends StatefulWidget {
  final String idpengguna;
  Disemak(this.idpengguna);

  @override
  _DisemakState createState() => _DisemakState();
}

class _DisemakState extends State<Disemak> {
  Future<List> lihatAduan() async {
    final response =
        await http.get(BaseUrl.lihataduandisemak(widget.idpengguna));
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

class Selesai extends StatefulWidget {
  final String idpengguna;
  Selesai(this.idpengguna);
  @override
  _SelesaiState createState() => _SelesaiState();
}

class _SelesaiState extends State<Selesai> {
  Future<List> lihatAduan() async {
    final response =
        await http.get(BaseUrl.lihataduanselesai(widget.idpengguna));
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

class TidakSelesai extends StatefulWidget {
  final String idpengguna;
  TidakSelesai(this.idpengguna);
  @override
  _TidakSelesaiState createState() => _TidakSelesaiState();
}

class _TidakSelesaiState extends State<TidakSelesai> {
  Future<List> lihatAduan() async {
    final response =
        await http.get(BaseUrl.lihataduantidakselesai(widget.idpengguna));
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
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();
  // String status, aduan_id;
  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
              "${widget.list[widget.index]['namaruang']}".toUpperCase()),
        ),
        body: buildpengadu());
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
      print("Status:" + _myActivityResult);
      print("Aduan Id:" + widget.list[widget.index]['aduan_id']);
      kemaskini();
    }
  }

  buildpengadu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: <Widget>[
              Image.network(
                BaseUrl.gambar() + widget.list[widget.index]['gambaraduan'],
                fit: BoxFit.cover,
                height: 180,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "${widget.list[widget.index]['tarikhaduan']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    margin: new EdgeInsets.all(0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new TextFormField(
                                    initialValue: widget.list[widget.index]
                                        ['fasiliti_id'],
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: "KOD FASILITI",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Container(
                                  child: new TextFormField(
                                    initialValue: widget.list[widget.index]
                                        ['namafasiliti'],
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: "NAMA FASILITI",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                          new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: new TextFormField(
                                    initialValue: widget.list[widget.index]
                                        ['ruang_id'],
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: "KOD LOKASI",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Container(
                                  child: new TextFormField(
                                    initialValue: widget.list[widget.index]
                                        ['namaruang'],
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: "LOKASI",
                                    ),
                                  ),
                                ),
                                flex: 2,
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: widget.list[widget.index]['maklumat'],
                            readOnly: true,
                            decoration: InputDecoration(
                                labelText: "MAKLUMAT",
                                hintText: "Masukkan maklumat kerosakan"),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            initialValue: widget.list[widget.index]['status'],
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Status",
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  buildjuruteknik() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(8),
                children: <Widget>[
                  Image.network(
                    BaseUrl.gambar() + widget.list[widget.index]['gambaraduan'],
                    fit: BoxFit.cover,
                    height: 180,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${widget.list[widget.index]['tarikhaduan']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        margin: new EdgeInsets.all(0.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new TextFormField(
                                        initialValue: widget.list[widget.index]
                                            ['fasiliti_id'],
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: "KOD FASILITI",
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Container(
                                      child: new TextFormField(
                                        initialValue: widget.list[widget.index]
                                            ['namafasiliti'],
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: "NAMA FASILITI",
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                              new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new TextFormField(
                                        initialValue: widget.list[widget.index]
                                            ['ruang_id'],
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: "KOD LOKASI",
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Container(
                                      child: new TextFormField(
                                        initialValue: widget.list[widget.index]
                                            ['namaruang'],
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          labelText: "LOKASI",
                                        ),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              ),
                              TextFormField(
                                initialValue: widget.list[widget.index]
                                    ['maklumat'],
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: "MAKLUMAT",
                                    hintText: "Masukkan maklumat kerosakan"),
                              ),
                              SizedBox(height: 10.0),
                              widget.list[widget.index]['status'] != 'disemak'
                                  ? TextFormField(
                                      initialValue: widget.list[widget.index]
                                          ['status'],
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: "Status",
                                      ),
                                    )
                                  : DropDownFormField(
                                      titleText: 'Status',
                                      hintText: widget.list[widget.index]
                                          ['status'],
                                      value: _myActivity,
                                      onSaved: (value) {
                                        setState(() {
                                          _myActivity = value;
                                        });
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _myActivity = value;
                                        });
                                      },
                                      dataSource: [
                                        {
                                          "display": "Disemak",
                                          "value": "disemak",
                                        },
                                        {
                                          "display": "Selesai",
                                          "value": "selesai",
                                        },
                                        {
                                          "display": "Tidak Selesai",
                                          "value": "tidakselesai",
                                        },
                                      ],
                                      textField: 'display',
                                      valueField: 'value',
                                    ),
                              SizedBox(height: 10.0),
                              widget.list[widget.index]['status'] != 'disemak'
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        _saveForm();
                                      },
                                      child: Container(
                                        height: 45.0,
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.blueAccent,
                                          elevation: 7.0,
                                          child: Center(
                                            child: Text(
                                              'KEMASKINI',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void kemaskini() async {
    final response = await http.post(BaseUrl.kemaskinistatus(), body: {
      "aduan_id": widget.list[widget.index]['aduan_id'],
      "status": _myActivityResult,
    });
    //   var datauser = json.decode(response.body);

    //   if (datauser.length == 0) {
    //     setState(
    //       () {
    //         Alert(
    //           context: context,
    //           title: "Kemaskini Berjaya !",
    //           desc: "Klik OK untuk keluar",
    //           buttons: [
    //             DialogButton(
    //               child: Text("OK"),
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //             ),
    //           ],
    //         ).show();
    //       },
    //     );
    //   } else {
    //     setState(
    //       () {
    //         Alert(
    //           context: context,
    //           title: "Kemaskini Tidak Berjaya",
    //           desc: "Sila cuba sekali lagi.",
    //           buttons: [
    //             DialogButton(
    //               color: Colors.red,
    //               child: Text("OK"),
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //             ),
    //           ],
    //         ).show();
    //       },
    //     );
    //   }

    //   print(response.body);
  }
}
