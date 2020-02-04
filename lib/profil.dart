import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  final namapenuh;
  Profil(String s, {Key key, this.namapenuh, String title}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  colors: [
                    const Color(0xff90A4AE),
                    const Color(0xFFFAFAFA),
                  ],
                  begin: Alignment.centerRight,
                  end: new Alignment(-1.0, -1.0),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  profilePage("${widget.namapenuh}", "Flutter Developer",
                      "Paris", "200", "www.baileyromero.com"),
                  ProfileImageWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned myImages(String images) {
    return Positioned(
      top: 0.0,
      left: 100.0,
      child: Container(
          width: 160.0,
          height: 160.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.fill, image: new NetworkImage(images)))),
    );
  }

  //Center Widget
  Center profilePage(String profileName, String jobDescription, String location,
      String followerVal, String webLink) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}

class ProfileImageWidget extends StatefulWidget {
  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  var height = 160.0;
  var width = 160.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.0,
      left: 100.0,
      child: Container(
        width: width,
        height: height,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage(
                "https://thenypost.files.wordpress.com/2019/04/pet-sematary-cat-2a.jpg?quality=90&strip=all&w=1054&h=702&crop=1"),
          ),
        ),
      ),
    );
  }
}
