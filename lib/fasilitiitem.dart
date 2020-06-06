import 'package:eaduanfsktm/kemaskinifasiliti.dart';
import 'package:eaduanfsktm/tambahfasiliti.dart';
import 'package:eaduanfsktm/widget/menuicon.dart';
import 'package:flutter/material.dart';

class FasilitiItem extends StatefulWidget {
  final idpengguna, namapenuh, kategoripengguna;
  FasilitiItem(
      {Key key, this.idpengguna, this.namapenuh, this.kategoripengguna})
      : super(key: key);
  @override
  _FasilitiItemState createState() => _FasilitiItemState();
}

class _FasilitiItemState extends State<FasilitiItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fasiliti"),
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
              "Tambah Fasiliti",
              Colors.lightBlueAccent,
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => TambahFasiliti())),
            ),
            MenuIcon(
              Icons.receipt,
              "Kemaskini Fasiliti",
              Colors.purpleAccent,
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => KemaskiniFasiliti())),
            ),
          ],
        ),
      ),
    );
  }
}
