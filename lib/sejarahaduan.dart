import 'package:flutter/material.dart';

class SejarahAduan extends StatefulWidget {
  @override
  _SejarahAduanState createState() => _SejarahAduanState();
}

class _SejarahAduanState extends State<SejarahAduan>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  /*@override
  void dispose() {
    controller.dispose;
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sejarah Aduan"),
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
                icon: new Text(
              "Disemak",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            )),
            new Tab(
                icon: new Text(
              "Selesai",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            )),
            new Tab(
                icon: new Text(
              "Tidak Selesai",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            )),
          ],
        ),
      ),
    );
  }
}
