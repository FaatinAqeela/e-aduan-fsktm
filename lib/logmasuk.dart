import 'package:eaduanfsktm/api.dart';
import 'package:eaduanfsktm/menuutama/menuutamajuruteknik.dart';
import 'package:eaduanfsktm/menuutama/menuutamapengguna.dart';
import 'package:eaduanfsktm/menuutama/menuutamapengurusmakmal.dart';
import 'package:eaduanfsktm/menuutama/menuutamapentadbir.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogMasuk extends StatefulWidget {
  @override
  _LogMasukState createState() => _LogMasukState();
}

class _LogMasukState extends State<LogMasuk> {
  TextEditingController idpengguna = new TextEditingController();
  TextEditingController katalaluan = new TextEditingController();
  final _key = new GlobalKey<FormState>();
  bool _obscureText = false;
  DateTime currentBackPressTime;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      logMasuk();
    }
  }

  Future<List> logMasuk() async {
    final response = await http.post(BaseUrl.logmasuk(), body: {
      "id_pengguna": idpengguna.text.toLowerCase(),
      "katalaluan": katalaluan.text,
    });
    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(
        () {
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
              ),
            ],
          ).show();
        },
      );
    } else {
      switch (datauser[0]['kategoripengguna']) {
        case 'pelajar':
        case 'staf':
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new MenuUtamaPengguna(datauser[0]['id_pengguna'])),
              (Route<dynamic> route) => false);

          break;

        case 'juruteknik':
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new MenuUtamaJuruteknik(datauser[0]['id_pengguna'])),
              (Route<dynamic> route) => false);
          break;

        case 'pentadbirsistem':
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new MenuUtamaPentadbirSistem(datauser[0]['id_pengguna'])),
              (Route<dynamic> route) => false);
          break;

        case 'pengurusmakmal':
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      new MenuUtamaPengurusMakmal(datauser[0]['id_pengguna'])),
              (Route<dynamic> route) => false);
          break;
        default:
      }
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Center(
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
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press back again to exit app");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget paparLogo() {
    return new Hero(
      tag: 'logo',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70.0,
          child: Image.asset('images/logo.png'),
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
                  keyboardType: TextInputType.text,
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
                  keyboardType: TextInputType.text,
                  obscureText: !_obscureText,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan kata laluan';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "KATA LALUAN",
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 45.0,
                  child: InkWell(
                    onTap: () {
                      if (_key.currentState.validate()) {
                        check();
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
