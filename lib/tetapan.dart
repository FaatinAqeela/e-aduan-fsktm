import 'package:eaduanfsktm/logmasuk.dart';
import 'package:eaduanfsktm/tukarkatalaluan.dart';
import 'package:flutter/material.dart';

class Tetapan extends StatefulWidget {
  @override
  _TetapanState createState() => _TetapanState();
}

class _TetapanState extends State<Tetapan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TETAPAN'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Tukar Kata Laluan',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TukarKataLaluan(),
                      ),
                    );
                  },
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                ListTile(
                  title: Text(
                    'Log Keluar',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  onTap: () {
                    showAlertDialog(context);
                  },
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (BuildContext context) => LogMasuk()),
            (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Keluar dari aplikasi?"),
      content: Text("Klik Ya untuk keluar!"),
      actions: [
        cancelButton,
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
