import 'package:flutter/material.dart';

class TentangKami extends StatefulWidget {
  @override
  _TentangKamiState createState() => _TentangKamiState();
}

class _TentangKamiState extends State<TentangKami> {
  //TextEditingController versi = 1.0;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('TENTANG KAMI'),
        ),
        body: ListView(
          children: <Widget>[
            new Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: TextFormField(
                    initialValue: '1.0',
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Versi Aplikasi",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EdgeInspect {}
