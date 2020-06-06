import 'package:eaduanfsktm/sejarahaduan.dart';
import 'package:eaduanfsktm/splashscreen.dart';
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
        primaryColor:  Colors.blueGrey[300],
        scaffoldBackgroundColor: const Color(0xffeceff1),
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        "/logmasuk": (context) => new LogMasuk(),
        "/sejarahaduan": (context) => new SejarahAduan(),
      },
    );
  }
}
