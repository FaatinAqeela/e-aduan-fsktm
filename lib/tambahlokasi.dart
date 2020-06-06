import 'package:flutter/material.dart';

class TambahLokasi extends StatefulWidget {
  @override
  _TambahLokasiState createState() => _TambahLokasiState();
}

class _TambahLokasiState extends State<TambahLokasi> {
  bool _status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Lokasi"),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            boxform(),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Widget boxform() {
    return Center(
      child: Card(
        elevation: 8.0,
        child: new Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'Nama Lokasi',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 0.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Flexible(
                              child: new TextField(
                                decoration: const InputDecoration(
                                    hintText: "R01-Makmal Pengaturcaraan"),
                                enabled: _status,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: new Text(
                                  'Lokasi',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                child: new Text(
                                  'Aras',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 0.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: new TextField(
                                  decoration:
                                      const InputDecoration(hintText: "G3"),
                                  enabled: _status,
                                ),
                              ),
                              flex: 2,
                            ),
                            Flexible(
                              child: new TextField(
                                decoration:
                                    const InputDecoration(hintText: "BK3"),
                                enabled: _status,
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'FASILITI',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: new Text(
                                  'Nama Fasiliti',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                child: new Text(
                                  'Kod Barangan',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25.0, top: 0.0),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: new TextField(
                                  decoration:
                                      const InputDecoration(hintText: "G3"),
                                  enabled: _status,
                                ),
                              ),
                              flex: 2,
                            ),
                            Flexible(
                              child: new TextField(
                                decoration:
                                    const InputDecoration(hintText: "BK3"),
                                enabled: _status,
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 45.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
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
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
