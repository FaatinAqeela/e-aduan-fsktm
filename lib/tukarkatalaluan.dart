import 'dart:convert';

import 'package:eaduanfsktm/api.dart';
import 'package:eaduanfsktm/tetapan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TukarKataLaluan extends StatefulWidget {
  final String idpengguna;
  TukarKataLaluan(this.idpengguna);
  @override
  _TukarKataLaluanState createState() => _TukarKataLaluanState();
}

class _TukarKataLaluanState extends State<TukarKataLaluan> {
  TextEditingController katalaluanbaru = new TextEditingController();
  TextEditingController sahkankatalaluan = new TextEditingController();
  final _key = new GlobalKey<FormState>();
  bool _obscureText = false;
  bool _obscureText2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: new Scaffold(
      appBar: AppBar(
        title: Text("Tukar Kata Laluan"),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            boxform(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    ));
  }

  Widget boxform() {
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
                    controller: katalaluanbaru,
                    obscureText: !_obscureText,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Masukkan Kata Laluan Baru';
                      } else if (value.length < 6) {
                        return "Kata laluan harus melebihi 6 angka ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Kata Laluan Baru",
                      hintText: 'Contoh : aLi123',
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    )),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: sahkankatalaluan,
                  obscureText: !_obscureText2,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Sahkan Kata Laluan';
                    } else if (value != katalaluanbaru.text) {
                      return 'Kata Laluan Tidak Sah';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Sahkan Kata Laluan",
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _obscureText2 ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                InkWell(
                  onTap: () {
                    if (_key.currentState.validate()) {
                      tukar();
                    }
                  },
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
                InkWell(
                  onTap: () {
                    setState(() {
                      katalaluanbaru.clear();
                      sahkankatalaluan.clear();
                    });
                  },
                  child: Container(
                    height: 45.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.red,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'RESET',
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

  tukar() async {
    final response =
        await http.post(BaseUrl.tukarkatalaluan(widget.idpengguna), body: {
      "katalaluanbaru": katalaluanbaru.text,
    });
    final data = jsonDecode(response.body);

    int value = data['value'];
    if (value == 1) {
      setState(() {
        showAlertDialog(context);
      });
    } else {
      print("not success");
    }
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Tetapan(widget.idpengguna)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Berjaya Tukar kata laluan!"),
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
