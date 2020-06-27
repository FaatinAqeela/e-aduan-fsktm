import 'dart:convert';
import 'package:eaduanfsktm/api.dart';
import 'package:eaduanfsktm/screenpentadbirsistem/tambahruang.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RuangFasiliti extends StatefulWidget {
  @override
  _RuangFasilitiState createState() => _RuangFasilitiState();
}

class _RuangFasilitiState extends State<RuangFasiliti> {
  Future<List> lihatruang() async {
    final response = await http.get(BaseUrl.lihatruang());
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: lihatruang(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? new RuangList(list: snapshot.data)
            : new Center(
                child: new CircularProgressIndicator(),
              );
      },
    );
  }
}

class RuangList extends StatelessWidget {
  final List list;
  RuangList({this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Senarai Ruang"),
      ),
      body: new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return new Container(
            padding: const EdgeInsets.all(1.0),
            child: new GestureDetector(
              onTap: () => Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new RuangDetails(
                    list: list,
                    index: i,
                  ),
                ),
              ),
              child: new Card(
                child: new ListTile(
                  title: Text(
                    '${list[i]['namaruang']}'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new RuangDetails(list: list, index: i),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new TambahRuang()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class RuangDetails extends StatefulWidget {
  final List list;
  final index;
  RuangDetails({this.list, this.index}) : super();

  //final String title = 'RUANG FASILITI';

  @override
  _RuangDetailsState createState() => _RuangDetailsState();
}

class _RuangDetailsState extends State<RuangDetails> {
 

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "${widget.list[widget.index]['namaruang']}".toUpperCase(),
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      // body: Text(ruangfasiliti.),

      // _build()
    );
  }
}
