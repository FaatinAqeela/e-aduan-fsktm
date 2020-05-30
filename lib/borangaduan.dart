import 'dart:convert';
import 'package:eaduanfsktm/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:eaduanfsktm/model/modelRuangFasiliti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as Math;
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:path/path.dart';

class BorangAduan extends StatefulWidget {
  final String idpengguna, barcode;
  BorangAduan(this.idpengguna, this.barcode);
  @override
  _BorangAduanState createState() => _BorangAduanState();
}

class _BorangAduanState extends State<BorangAduan> {
  final _key = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  RuangFasiliti ruangfasiliti;

  TextEditingController controllerruang_id;
  TextEditingController controllerfasiliti_id;
  TextEditingController controller_namaruang;
  TextEditingController controller_namafasiliti;
  TextEditingController controllermaklumat = new TextEditingController();

  File _image;

  Future<RuangFasiliti> getruangfasiliti() async {
    await http.get(BaseUrl.lihatruangfasiliti(widget.barcode)).then((response) {
      if (jsonDecode(response.body) != null) {
        setState(() {
          ruangfasiliti = RuangFasiliti.fromJson(jsonDecode(response.body));
        });

        setState(() {
          controllerruang_id =
              new TextEditingController(text: "${ruangfasiliti.ruang_id}");
          controllerfasiliti_id =
              new TextEditingController(text: "${ruangfasiliti.fasiliti_id}");
          controller_namaruang =
              new TextEditingController(text: " ${ruangfasiliti.namaruang}");
          controller_namafasiliti =
              new TextEditingController(text: " ${ruangfasiliti.namafasiliti}");
        });
      }
    });
    return ruangfasiliti;
  }

  @override
  void initState() {
    getruangfasiliti();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Borang Aduan"),
          ),
          body: ruangfasiliti == null
              ? Container(
                  child: AlertDialog(
                    title: Text('Data tiada dalam sistem!'),
                    content: const Text('Sila Cuba lagi..'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: ListView(
                      padding: EdgeInsets.all(15.0),
                      children: <Widget>[
                        aduanbox(),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                )),
    );
  }

  Widget aduanbox() {
    return Center(
      child: Card(
        elevation: 8.0,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: new TextFormField(
                          controller: controllerfasiliti_id,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "KOD FASILITI",
                            // suffixIcon: GestureDetector(
                            //   onTap: () {
                            //     //scan();
                            //   },
                            // child: Column(
                            //   children: <Widget>[
                            //     Icon(
                            //       MdiIcons.qrcode,
                            //       size: 35,
                            //       color: Colors.black,
                            //     ),
                            //     Text("Scan Me")
                            //   ],
                            // ),
                            // ),
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        child: new TextFormField(
                          controller: controller_namafasiliti,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "NAMA FASILITI",
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: new TextFormField(
                          controller: controllerruang_id,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "KOD LOKASI",
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        child: new TextFormField(
                          controller: controller_namaruang,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "LOKASI",
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                TextFormField(
                  controller: controllermaklumat,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Masukkan Maklumat Kerosakan';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "MAKLUMAT",
                      hintText: "Masukkan maklumat kerosakan"),
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Icon(Icons.image),
                      onPressed: getImageGallery,
                    ),
                    SizedBox(width: 5.0),
                    RaisedButton(
                      child: Icon(Icons.camera_alt),
                      onPressed: getImageCamera,
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  child: _image == null
                      ? new Text("Tiada imej !")
                      : new Image.file(_image),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 45.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_key.currentState.validate()) {
                        tambahaduan(_image);
                      }
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueAccent,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'HANTAR',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _alert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not in stock'),
          content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future getImageGallery() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  Future getImageCamera() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 500);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
    });
  }

  Future tambahaduan(File _image) async {
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    var length = await _image.length();
    var uri = Uri.parse((BaseUrl.tambahaduan()));

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("aduanimages", stream, length,
        filename: basename(_image.path));
    request.fields['fasiliti_id'] = controllerfasiliti_id.text;
    request.fields['ruang_id'] = controllerruang_id.text;
    request.fields['maklumat'] = controllermaklumat.text;
    request.fields['idpengguna'] = widget.idpengguna;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image Uploaded");
      setState(
        () {
          Fluttertoast.showToast(
            msg: "Aduan Berjaya",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 18.0,
          );
        },
      );
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
