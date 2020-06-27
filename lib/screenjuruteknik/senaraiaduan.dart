import 'dart:convert';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:eaduanfsktm/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SenaraiAduan extends StatefulWidget {
  final String idjuruteknik;
  SenaraiAduan(this.idjuruteknik);

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
              title: Text('Senarai Aduan'),
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
              AduanDisemak(widget.idjuruteknik),
              AduanSelesai(widget.idjuruteknik),
              AduanTidakSelesai(widget.idjuruteknik),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}

class AduanDisemak extends StatefulWidget {
  final String idjuruteknik;
  AduanDisemak(this.idjuruteknik);
  @override
  _AduanDisemakState createState() => _AduanDisemakState();
}

class _AduanDisemakState extends State<AduanDisemak> {
  Future<List> senaraiaduandisemak() async {
    final response =
        await http.get(BaseUrl.senaraiaduandisemak(widget.idjuruteknik));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
      future: senaraiaduandisemak(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new ItemAduan(list: snapshot.data)
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class AduanSelesai extends StatefulWidget {
  final String idjuruteknik;
  AduanSelesai(this.idjuruteknik);
  @override
  _AduanSelesaiState createState() => _AduanSelesaiState();
}

class _AduanSelesaiState extends State<AduanSelesai> {
  Future<List> senaraiaduanselesai() async {
    final response =
        await http.get(BaseUrl.senaraiaduanselesai(widget.idjuruteknik));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: senaraiaduanselesai(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new ItemAduan(list: snapshot.data)
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class AduanTidakSelesai extends StatefulWidget {
  final String idjuruteknik;
  AduanTidakSelesai(this.idjuruteknik);
  @override
  _AduanTidakSelesaiState createState() => _AduanTidakSelesaiState();
}

class _AduanTidakSelesaiState extends State<AduanTidakSelesai> {
  Future<List> senaraiaduantidakselesai() async {
    final response =
        await http.get(BaseUrl.senaraiaduantidakselesai(widget.idjuruteknik));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
      future: senaraiaduantidakselesai(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);
        return snapshot.hasData
            ? new ItemAduan(list: snapshot.data)
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class ItemAduan extends StatelessWidget {
  final List list;

  ItemAduan({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: EdgeInsets.all(2.0),
          child: new GestureDetector(
            // onTap: () {
            //   Navigator.of(context).push(new MaterialPageRoute(
            //     builder: (BuildContext context) => new DetailAduan(
            //       index: i,
            //       list: list,
            //     ),
            //   ));
            // },
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
                        new DetailAduan(list: list, index: i),
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

class DetailAduan extends StatefulWidget {
  final List list;
  final index;

  DetailAduan({this.list, this.index});
  @override
  _DetailAduanState createState() => _DetailAduanState();
}

class _DetailAduanState extends State<DetailAduan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(
              "${widget.list[widget.index]['namaruang']}".toUpperCase()),
        ),
        body: buildjuruteknik());
  }

  buildjuruteknik() {
    return Container(
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
                                      print("Status:" + _myActivity);
                                      print("Aduan Id:" +
                                          widget.list[widget.index]
                                              ['aduan_id']);

                                      kemaskini();
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
    );
  }

  String _myActivity;

  // void kemaskini() {
  //   var url = BaseUrl.kemaskinistatus();
  //   http.post(url, body: {
  //     "aduan_id": widget.list[widget.index]['aduan_id'],
  //     "status": _myActivity,
  //   });
  // }

  kemaskini() async {
    final response = await http.post(BaseUrl.kemaskinistatus(), body: {
      "aduan_id": widget.list[widget.index]['aduan_id'],
      "status": _myActivity,
    });
    final data = jsonDecode(response.body);

    int value = data['value'];
    if (value == 1) {
      setState(() {
        print("success");
        // showAlertDialog(context);
      });
    } else {
      print("not success");
    }
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        CircularProgressIndicator();
        Navigator.pop(context);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => SenaraiAduan()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Kemaskini Berjaya!"),
      content: Text("Klik OK untuk keluar!"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
