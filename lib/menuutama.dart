import 'package:eaduanfsktm/borangaduan.dart';
import 'package:flutter/material.dart';

class MenuUtama extends StatelessWidget {
  final idpengguna, namapenuh, kategoripengguna;
  MenuUtama({Key key, this.idpengguna, this.namapenuh, this.kategoripengguna})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MENU UTAMA"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                "${this.namapenuh}".toUpperCase(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              accountEmail: new Text("${this.idpengguna}".toUpperCase()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://thenypost.files.wordpress.com/2019/04/pet-sematary-cat-2a.jpg?quality=90&strip=all&w=1054&h=702&crop=1"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text("Tukar Kata Laluan"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Tetapan"),
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
      ), //myDrawer(),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            _menuutama(Icons.note_add, "Borang Aduan", Colors.lightBlueAccent),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => BorangAduan())),
          ),
          /* _buildTile(
            _menuutama(Icons.history, "Sejarah", Colors.grey),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SejarahAduan())),
          ), 
          _buildTile(
            _menuutama(Icons.history, "Sejarah Aduan", Colors.greenAccent),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TambahAduan())),
          ),
          _buildTile(
            _menuutama(Icons.settings, "Tetapan", Colors.blueGrey),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TambahAduan())),
          ),
          _buildTile(
            _menuutama(Icons.info, "Tentang Kami", Colors.blue),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => TambahAduan())),
          ),*/
        ],
      ),
    );
  }

  Material _menuutama(IconData icon, String tajuk, Color color) {
    return Material(
      color: Colors.white,
      elevation: 7.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: color,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        tajuk,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
