import 'package:flutter/material.dart';

class TukarKataLaluan extends StatefulWidget {
  @override
  _TukarKataLaluanState createState() => _TukarKataLaluanState();
}

class _TukarKataLaluanState extends State<TukarKataLaluan> {
  TextEditingController katalaluanlama = new TextEditingController();
  TextEditingController katalaluanbaru = new TextEditingController();
  TextEditingController sahkankatalaluan = new TextEditingController();
  final _key = new GlobalKey<FormState>();

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
                  controller: katalaluanlama,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan Kata Laluan Lama';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Kata Laluan Lama",
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: katalaluanbaru,
                  obscureText: true,
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
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: sahkankatalaluan,
                  obscureText: true,
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
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(height: 10.0),
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
                      katalaluanlama.clear();
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

  void tukar() {
    print('Tukar kata laluan');
  }
}
