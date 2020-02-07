import 'package:eaduanfsktm/menuutamapentadbir.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'menuutama.dart';

class LogMasuk extends StatefulWidget {
  @override
  _LogMasukState createState() => _LogMasukState();
}

class _LogMasukState extends State<LogMasuk> {
  TextEditingController idpengguna = new TextEditingController();
  TextEditingController katalaluan = new TextEditingController();
  final _key = new GlobalKey<FormState>();

  Future<List> logMasuk() async {
    //var url = "https://e-aduanfsktm.000webhostapp.com/logmasuk.php";
    var url = "http://172.16.41.132/E-Aduan/logmasuk.php";
    final response = await http.post(url, body: {
      "id_pengguna": idpengguna.text.toLowerCase(),
      "katalaluan": katalaluan.text,
    });
    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        Alert(
            context: context,
            title: "Salah Nama Pengguna dan Kata Laluan",
            desc: "Sila cuba lagi.",
            buttons: [
              DialogButton(
                color: Colors.red,
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]).show();
      });
    } else {
      switch (datauser[0]['kategoripengguna']) {
        case 'pelajar':
        case 'staf':
          var route = new MaterialPageRoute(
            builder: (BuildContext context) {
              var menuUtama = new MenuUtamaPengguna(
                tajuk: 'MENU UTAMA',
                idpengguna: datauser[0]['id_pengguna'],
                namapenuh: datauser[0]['namapenuh'],
                kategoripengguna: datauser[0]['kategoripengguna'],
              );
              return menuUtama;
            },
          );
          Navigator.of(context).push(route);
          break;
        case 'pentadbirsistem':
          var route = new MaterialPageRoute(
            builder: (BuildContext context) {
              var menuUtama = new MenuUtamaPentadbirSistem(
                idpengguna: datauser[0]['id_pengguna'],
                namapenuh: datauser[0]['namapenuh'],
                kategoripengguna: datauser[0]['kategoripengguna'],
              );
              return menuUtama;
            },
          );
          Navigator.of(context).push(route);
          break;
        case 'staf':
          var route = new MaterialPageRoute(
            builder: (BuildContext context) {
              var menuUtama = new MenuUtamaPentadbirSistem(
                idpengguna: datauser[0]['id_pengguna'],
                namapenuh: datauser[0]['namapenuh'],
                kategoripengguna: datauser[0]['kategoripengguna'],
              );
              return menuUtama;
            },
          );
          Navigator.of(context).push(route);
          break;
        case 'pengurusmakmal':
          var route = new MaterialPageRoute(
            builder: (BuildContext context) {
              var menuUtama = new MenuUtamaPentadbirSistem(
                idpengguna: datauser[0]['id_pengguna'],
                namapenuh: datauser[0]['namapenuh'],
                kategoripengguna: datauser[0]['kategoripengguna'],
              );
              return menuUtama;
            },
          );
          Navigator.of(context).push(route);
          break;

        default:
      }
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            paparLogo(),
            logmasukbox(),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Lupa kata laluan?",
                    style: TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget paparLogo() {
    return new Hero(
      tag: 'logo',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: Image.asset('images/logos.png'),
        ),
      ),
    );
  }

  Widget logmasukbox() {
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
                  controller: idpengguna,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan ID Pengguna';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "ID PENGGUNA",
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: katalaluan,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan kata laluan';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "KATA LALUAN",
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 45.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_key.currentState.validate()) {
                        logMasuk();
                      }
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueAccent,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'LOG MASUK',
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
