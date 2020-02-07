import 'package:eaduanfsktm/profil.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends Drawer {
  final idpengguna, namapenuh;
  CustomDrawer(this.idpengguna, this.namapenuh);

  @override
  Widget build(BuildContext context) => new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                this.namapenuh.toUpperCase(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              accountEmail: new Text(this.idpengguna.toUpperCase()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://thenypost.files.wordpress.com/2019/04/pet-sematary-cat-2a.jpg?quality=90&strip=all&w=1054&h=702&crop=1"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
              onTap: () {
                Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new Profil(this.namapenuh),
                  ),
                );

                //_lihatprofil();
              },
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text("Tukar Kata Laluan"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Tetapan"),
              onTap: () {},
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Log Keluar"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/logmasuk");
                  //Navigator.of(context).pushReplacementNamed('/logmasuk');
                }),
          ],
        ),
      );
}
