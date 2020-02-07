import 'package:eaduanfsktm/borangaduan.dart';
import 'package:eaduanfsktm/drawer.dart';
import 'package:eaduanfsktm/sejarahaduan.dart';
import 'package:flutter/material.dart';

class MenuUtamaPengguna extends StatefulWidget {
  final tajuk, idpengguna, namapenuh, kategoripengguna;
  MenuUtamaPengguna(
      {Key key,
      this.tajuk,
      this.idpengguna,
      this.namapenuh,
      this.kategoripengguna,
      String title})
      : super(key: key);
  @override
  _MenuUtamaPenggunaState createState() => _MenuUtamaPenggunaState();
}

class _MenuUtamaPenggunaState extends State<MenuUtamaPengguna> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.tajuk),
      ),
      drawer: CustomDrawer("${widget.idpengguna}","${widget.namapenuh}"),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            menuIcon(Icons.note_add, "Borang Aduan", Colors.lightBlueAccent),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => BorangAduan())),
          ),
          _buildTile(
            menuIcon(Icons.history, "Sejarah", Colors.purple[300]),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SejarahAduan())),
          ),
          _buildTile(
            menuIcon(Icons.settings, "Tetapan", Colors.blueGrey),
            //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TambahAduan())),
          ),
          _buildTile(
            menuIcon(Icons.info, "Tentang Kami", Colors.blue),
            //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TambahAduan())),
          ),
        ],
      ),
    );
  }


  Material menuIcon(IconData icon, String tajuk, Color color) {
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
