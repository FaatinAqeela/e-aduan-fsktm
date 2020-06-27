import 'package:eaduanfsktm/screenpentadbirsistem/JuruteknikItem.dart';
import 'package:eaduanfsktm/screenpentadbirsistem/fasilitiitem.dart';
import 'package:eaduanfsktm/screenpentadbirsistem/ruangfasiliti.dart';
import 'package:eaduanfsktm/screenpentadbirsistem/tambahruang.dart';
import 'package:eaduanfsktm/widget/drawer.dart';
import 'package:eaduanfsktm/widget/menuicon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuUtamaPentadbirSistem extends StatefulWidget {
  final idpengguna;
  MenuUtamaPentadbirSistem(this.idpengguna);
  @override
  _MenuUtamaPentadbirSistemState createState() =>
      _MenuUtamaPentadbirSistemState();
}

class _MenuUtamaPentadbirSistemState extends State<MenuUtamaPentadbirSistem> {
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
              Icons.map,
              "Ruang",
              Colors.tealAccent,
              () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (BuildContext context) => TambahRuang())),
            ),
            MenuIcon(
              Icons.account_balance,
              "Fasiliti",
              Colors.blueGrey[300],
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => FasilitiItem())),
            ),
            MenuIcon(
              Icons.memory,
              "Ruang x Fasiliti",
              Colors.red[200],
              () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RuangFasiliti())),
            ),
          ],
        ),
      ),
    );
  }
}
