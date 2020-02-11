import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  final icon, tajuk, color;
  final Function ontap;
  MenuIcon(this.icon, this.tajuk, this.color, this.ontap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap != null
          ? () => ontap()
          : () {
              print('Not set yet');
            },
      child: Material(
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
      ),
    );
  }
}
