import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eaduanfsktm/api.dart';
import 'package:eaduanfsktm/logmasuk.dart';
import 'package:eaduanfsktm/model/modelPengguna.dart';
import 'package:eaduanfsktm/profil.dart';
import 'package:eaduanfsktm/tentangkami.dart';
import 'package:eaduanfsktm/tetapan.dart';
import 'package:eaduanfsktm/tukarkatalaluan.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends Drawer {
  final idpengguna;
  CustomDrawer(this.idpengguna);

  @override
  Widget build(BuildContext context) => new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                "Nama",
                //this.namapenuh.toUpperCase(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Colors.white,
                  backgroundColor: Colors.grey[400],
                ),
              ),
              accountEmail: new Text(
                this.idpengguna.toUpperCase(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  color: Colors.white,
                  backgroundColor: Colors.grey,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://thenypost.files.wordpress.com/2019/04/pet-sematary-cat-2a.jpg?quality=90&strip=all&w=1054&h=702&crop=1"),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/5670822c-a2fc-4e16-9c3d-340775308cb0/d7bufy3-16d78b32-3537-42d6-9851-f2f349102563.jpg/v1/fill/w_1024,h_1024,q_75,strp/fsktm__uthm_by_zufairi_d7bufy3-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD0xMDI0IiwicGF0aCI6IlwvZlwvNTY3MDgyMmMtYTJmYy00ZTE2LTljM2QtMzQwNzc1MzA4Y2IwXC9kN2J1ZnkzLTE2ZDc4YjMyLTM1MzctNDJkNi05ODUxLWYyZjM0OTEwMjU2My5qcGciLCJ3aWR0aCI6Ijw9MTAyNCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.usz7FpqFC7XcgWDbw3pU1e61NptpZjPX_STCkpGZX0c'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new Profil(this.idpengguna),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text("Tukar Kata Laluan"),
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new TukarKataLaluan(this.idpengguna),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Tetapan"),
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new Tetapan(this.idpengguna),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Tentang Kami"),
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new TentangKami(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Log Keluar"),
              onTap: () {
                showAlertDialog(context);
              },
            ),
          ],
        ),
      );
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
