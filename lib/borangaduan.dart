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

  TextEditingController controllerruang_id;
  TextEditingController controllerfasiliti_id;
  TextEditingController controller_namaruang;
  TextEditingController controller_namafasiliti;
  TextEditingController controllermaklumat = new TextEditingController();
  bool condition = false;
  File _image;
  RuangFasiliti ruangfasiliti = new RuangFasiliti();

  Future<RuangFasiliti> getruangfasiliti() async {
    final response = await http.get(BaseUrl.lihatruangfasiliti(widget.barcode));
    if (response.statusCode == 200 && json.decode(response.body) != null) {
      setState(
        () {
          print(json.decode(response.body));
          ruangfasiliti = RuangFasiliti.fromJson(json.decode(response.body));
          controllerruang_id =
              new TextEditingController(text: "${ruangfasiliti.ruang_id}");
          controllerfasiliti_id =
              new TextEditingController(text: "${ruangfasiliti.fasiliti_id}");
          controller_namaruang =
              new TextEditingController(text: " ${ruangfasiliti.namaruang}");
          controller_namafasiliti =
              new TextEditingController(text: " ${ruangfasiliti.namafasiliti}");
        },
      );
      setState(() {
        condition = true;
      });
    } else {}
    return ruangfasiliti;
  }

  @override
  void initState() {
    super.initState();
    getruangfasiliti();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Borang Aduan"),
        ),
        body: Container(
            child: condition
                ? new ListView(
                    children: <Widget>[
                      aduanbox(),
                      SizedBox(height: 10.0),
                    ],
                  )
                : new CircularProgressIndicator()),
      ),
    );
  }

  Widget aduanbox() {
    return Container(
      child: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            //color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
      ),
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

    request.fields['ruang_id'] = controllerruang_id.text;
    request.fields['fasiliti_id'] = controllerfasiliti_id.text;
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
          // Navigator.of(this.context).push(CupertinoPageRoute(
          //     builder: (BuildContext context) => SejarahAduan()));
          Navigator.pop(this.context);
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
