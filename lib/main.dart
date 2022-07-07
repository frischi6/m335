import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:m335/model/gameImage.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'model/object.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'letsgo M335'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //!!
  double xStart = 0;
  double yStart = 30;
  double xEnd = 0;
  double yEnd = -150;

  double xAlignTarget = 0.6;

  double targetX = 150;

  bool boolVisible = false;

  int points = 0;

  double xRandomTarget = 0;

  double xValue = 0;
  double yValueBoard = 1;
  double yValueBullet = 1;
  //double yValueBullet = 0.3;
  late StreamSubscription subscription;

  double bottomBullet = 150;

  @override
  void initState() {
    super.initState();
    subscription = accelerometerEvents.listen((event) {
      setState(() {
        moveImg(event.x);
      });
    });
  }

  bulletRunTarget() {
    setState(() {
      //xStart = xEnd;
      boolVisible = true;
      yStart = MediaQuery.of(context).size.height;
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (xRandomTarget + 0.15 >= xValue && xRandomTarget - 0.15 <= xValue) {
        setState(() {
          points++;
        });
      }
      generateRandomTargetX();
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      resetBulletPosition();
    });
  }

//hier noch schauen, dass auch negative zahl
//Random().nextDouble() gibt Zahl zwischen 0 und 1
  generateRandomTargetX() {
    setState(() {
      bool randomBool = Random().nextBool();
      if (randomBool) {
        xRandomTarget = Random().nextDouble();
      } else {
        xRandomTarget = Random().nextDouble() * -1;
      }
    });
  }

  resetBulletPosition() {
    setState(() {
      boolVisible = false;
      yValueBullet = yValueBoard;
      yStart = 30;
    });
  }

  void moveImg(double effectiveX) {
    double theEffectiveX = effectiveX;
    setState(() {
      if (theEffectiveX > 2.0) {
        theEffectiveX = 2.0;
      } else if (theEffectiveX < -2.0) {
        theEffectiveX = -2.0;
      }

      xValue = theEffectiveX / 2.0 * -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: (Text('Erzielte Punkte: $points')),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  //background
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                ),
                AnimatedPositioned(
                  //target
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 500),
                  top: 0,
                  left: xStart.toDouble(),
                  child: Container(
                    child: Container(
                      color: Colors.green,
                      height: 5,
                      width: 45,
                    ),
                    alignment: Alignment(xRandomTarget, -1),
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    color: Colors.black,
                  ),
                ),
                AnimatedPositioned(
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 1000),
                    bottom: yStart.toDouble(),
                    left: xStart.toDouble(),

                    //objekt
                    child: Visibility(
                      child: Container(
                        child: Objekt(),
                        alignment: Alignment(xValue,
                            yValueBullet), //diesen wert hat geschossene kugel
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        color: Colors.black,
                      ),
                      visible: boolVisible,
                    )),
                Positioned(
                  //board
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    child: GameImage(),
                    alignment: Alignment(xValue, yValueBoard),
                    width: MediaQuery.of(context).size.width,
                    height: 90,
                    color: Colors.black,
                  ),
                  bottom: 30,
                ),
                Positioned(
                  child: ElevatedButton(
                    child: Text(
                      'shoot',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      bulletRunTarget();
                    },
                  ),
                  bottom: 0,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
              ],
            ))
        /*.Stack(
  children: <Widget>[
    Container(
      width: 100,
      height: 100,
      color: Colors.red,
    ),
    Container(
      width: 90,
      height: 90,
      color: Colors.green,
    ),
    Container(
      width: 80,
      height: 80,
      color: Colors.blue,
    ),
  ],
)*/

        ;
  }
}
