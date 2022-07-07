import 'dart:async';

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
  double yStart = 500;
  double xTarget = 0;
  double yTarget = 10;

  double xValue = 0;
  double yValueBoard = 0.3;
  double yValueBullet = 0.3;
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

  method() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          xStart = xTarget;
          yStart = yTarget;
        });
      }
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
    double a = 50;
    double b = 50;

    moveBullet() {
      setState(() {
        a = 160;
      });
    }

    return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: (Text('erzielte Punkte')),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  //background
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                ),
                Positioned(
                  //target
                  child: Container(
                    width: 50,
                    height: 9,
                    color: Colors.green,
                  ),
                  top: 0,
                  right: MediaQuery.of(context).size.width * 0.3,
                ),
                AnimatedPositioned(
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 1000),
                  top: yStart.toDouble(),
                  left: xStart.toDouble(),

                  //objekt
                  child: Container(
                    child: Objekt(),
                    //alignment: Alignment(xValue, yValueBoard),
                    width: MediaQuery.of(context).size.width,
                    //width: 100,
                    height: 90,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  //board
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    child: GameImage(),
                    alignment: Alignment(xValue, yValueBoard),
                    width: MediaQuery.of(context).size.width,
                    //width: 80,
                    height: 90,
                    color: Colors.black,
                  ),
                  //bottom: b,
                  top: 500,
                ),
                Positioned(
                  child: ElevatedButton(
                    child: Text(
                      'shoot',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      method();
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
