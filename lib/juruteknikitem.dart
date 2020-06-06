import 'package:eaduanfsktm/tambahjuruteknik.dart';
import 'package:eaduanfsktm/widget/menuicon.dart';
import 'package:flutter/material.dart';

class JuruteknikItem extends StatefulWidget {
  final idpengguna, namapenuh, kategoripengguna;
  JuruteknikItem(
      {Key key, this.idpengguna, this.namapenuh, this.kategoripengguna})
      : super(key: key);
  @override
  _JuruteknikItemState createState() => _JuruteknikItemState();
}

class _JuruteknikItemState extends State<JuruteknikItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Juruteknik"),
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            MenuIcon(
              Icons.note_add,
              "Daftar Juruteknik",
              Colors.lightBlueAccent,
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => TambahJuruteknik())),
            ),
            MenuIcon(
              Icons.search,
              "Cari Juruteknik",
              Colors.blueGrey,
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => TambahJuruteknik())),
            ),
            // MenuIcon(
            //   Icons.receipt,
            //   "Kemaskini",
            //   Colors.purple[300],
            //   () => Navigator.of(context)
            //       .push(MaterialPageRoute(builder: (_) => BorangAduan())),
            // ),
          ],
        ),
      ),
    );
  }
}
