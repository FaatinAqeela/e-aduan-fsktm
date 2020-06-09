import 'package:eaduanfsktm/api.dart';
import 'package:eaduanfsktm/borangaduan.dart';
import 'package:eaduanfsktm/logmasuk.dart';
import 'package:eaduanfsktm/model/modelPengguna.dart';
import 'package:eaduanfsktm/sejarahaduan.dart';
import 'package:eaduanfsktm/tetapan.dart';
import 'package:eaduanfsktm/tentangkami.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuUtamaPengguna extends StatefulWidget {
  final String idpengguna;
  MenuUtamaPengguna(this.idpengguna);
  @override
  _MenuUtamaPenggunaState createState() => _MenuUtamaPenggunaState();
}

class _MenuUtamaPenggunaState extends State<MenuUtamaPengguna> {
  String barcode = "";

  var logoImage = 'images/logo.png';
  bool isLoading = false;

  Future<Pengguna> _getpengguna() async {
    final response = await http.get(BaseUrl.lihatpengguna(widget.idpengguna));
    if (response.statusCode == 200) {
      return Pengguna.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load pengguna');
    }
  }

  @override
  void initState() {
    _getpengguna();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xff333), // status bar color
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      //drawer: CustomDrawer(idpengguna),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: FutureBuilder<Pengguna>(
            future: _getpengguna(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new Container(
                                    alignment: Alignment.centerLeft,
                                    margin: new EdgeInsets.only(bottom: 10.0),
                                    child: new Text(
                                      "Hi,${snapshot.data.namapenuh}",
                                      style: new TextStyle(
                                        //color: primaryTextColor,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.1,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showAlertDialog(context);
                                    },
                                    icon: Icon(
                                      Icons.lock_open,
                                      size: 30,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 200,
                                      alignment: Alignment.center,
                                      child: new Image.asset(
                                        logoImage,
                                        fit: BoxFit.contain,
                                        height: 130.0,
                                        width: 130.0,
                                      ),
                                      decoration: new BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(90.0),
                                          border: Border.all(
                                              color: Color(0xff37474f),
                                              style: BorderStyle.solid,
                                              width: 20),
                                          color: Colors.transparent),
                                    ),
                                  ],
                                ),
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Wrap(
                                spacing: 17,
                                runSpacing: 17,
                                children: [
                                  Item(
                                    title: 'Scan QR',
                                    icon: 'images/scanqr.png',
                                    color: 0xff453658,
                                    nav: () => scan(),
                                  ),
                                  Item(
                                    title: 'Sejarah Aduan',
                                    icon: 'images/semakaduan.png',
                                    color: 0xffFD637B,
                                    nav: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => SejarahAduan(
                                                snapshot.data.idpengguna))),
                                  ),
                                  Item(
                                    title: 'Tetapan',
                                    icon: 'images/tetapan.png',
                                    color: 0xff21CDFF,
                                    nav: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => Tetapan())),
                                  ),
                                  Item(
                                    title: 'Tentang Kami',
                                    icon: 'images/tentangkami.png',
                                    color: 0xff7585F6,
                                    nav: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => TentangKami())),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

//scan barcode
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BorangAduan(widget.idpengguna, this.barcode)));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
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

//icon menu
class Item extends StatelessWidget {
  final String title;
  final String icon;
  final dynamic color;
  final Function nav;

  Item({this.title, this.icon, this.color, this.nav});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: nav,
      child: Container(
        width: (screenWidth - 40 - 17) / 2,
        height: (screenWidth - 40 - 17 - 30) / 2,
        decoration: BoxDecoration(
            color: Color(color), borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Image.asset(icon,
                height: 55.0, width: 55.0, color: Colors.white),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Text(title,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}
