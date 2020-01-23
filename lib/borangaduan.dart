import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorangAduan extends StatefulWidget {
  @override
  _BorangAduanState createState() => _BorangAduanState();
}

class _BorangAduanState extends State<BorangAduan> {
  final _key = new GlobalKey<FormState>();
  String aduankepada, jenisaduan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Borang Aduan"),
      ),
      body: Center(
        child: ListView(
          //shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            aduanbox(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget aduanbox() {
    return Center(
      child: Card(
        elevation: 8.0,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  //controller: lokasi,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan Lokasi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.person),
                    labelText: "LOKASI",
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  //controller: katalaluan,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan Jenis Kerosakan';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.lock),
                    labelText: "JENIS KEROSAKAN",
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  //controller: katalaluan,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan Maklumat';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.lock),
                    labelText: "MAKLUMAT",
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  //controller: katalaluan,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan Gambar';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.lock),
                    labelText: "GAMBAR",
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 45.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_key.currentState.validate()) {
                        //logMasuk();
                      }
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueAccent,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'HANTAR',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
