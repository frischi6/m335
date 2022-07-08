import 'package:flutter/material.dart';

class GameImage extends StatelessWidget {
  GameImage({Key? key, required this.chosenWorld}) : super(key: key) {}

  int chosenWorld;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(getImage()),
      height: 80,
      width: 80,
    );
  }

  String getImage() {
    if (chosenWorld == 0) {
      return 'images/rakete.png';
    } else {
      return 'images/player.png';
    }
  }
}
