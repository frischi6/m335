import 'package:flutter/material.dart';

class Objekt extends StatelessWidget {
  Objekt({Key? key, required this.chosenWorld}) : super(key: key) {}
  int chosenWorld;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(getImage()),
      height: 50,
      width: 50,
    );
  }

  String getImage() {
    if (chosenWorld == 0) {
      return 'images/flame.png';
    } else {
      return 'images/fussball.png';
    }
  }
}
