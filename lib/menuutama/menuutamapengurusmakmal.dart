import 'package:eaduanfsktm/screenpentadbirsistem/juruteknikitem.dart';
import 'package:eaduanfsktm/tentangkami.dart';
import 'package:eaduanfsktm/tetapan.dart';
import 'package:eaduanfsktm/widget/drawer.dart';
import 'package:eaduanfsktm/widget/menuicon.dart';
import 'package:flutter/material.dart';

class MenuUtamaPengurusMakmal extends StatefulWidget {
  final String idpengguna;
  MenuUtamaPengurusMakmal(this.idpengguna);
  @override
  _MenuUtamaPengurusMakmalState createState() =>
      _MenuUtamaPengurusMakmalState();
}

class _MenuUtamaPengurusMakmalState extends State<MenuUtamaPengurusMakmal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MENU UTAMA"),
      ),
      drawer: CustomDrawer("${widget.idpengguna}"),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            MenuIcon(
              Icons.build,
              "Juruteknik",
              Colors.lime,
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => JuruteknikItem())),
            ),
            MenuIcon(
              Icons.settings,
              "Tetapan",
              Colors.blueGrey,
              () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => Tetapan(widget.idpengguna))),
            ),
            MenuIcon(
              Icons.info,
              "Tentang Kami",
              Colors.blue,
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => TentangKami())),
            ),
          
          ],
        ),
      ),
    );
  }
}
