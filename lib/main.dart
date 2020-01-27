import 'package:flutter/material.dart';
import 'logmasuk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ('E-Aduan FSKTM'),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: LogMasuk(),
      routes: <String, WidgetBuilder>{
        '/logmasuk': (BuildContext context) => new LogMasuk(),
      },
    );
  }
}
