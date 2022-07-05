import 'dart:async';

import 'package:flutter/material.dart';
import 'package:m335/model/gameImage.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  double xValue = 0;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = accelerometerEvents.listen((event) {
      setState(() {
        moveImg(event.x);
      });
    });
  }

  void moveImg(double effectiveX) {
    double theEffectiveX = effectiveX;
    setState(() {
      if (theEffectiveX > 2.2) {
        theEffectiveX = 2.2;
      } else if (theEffectiveX < -2.2) {
        theEffectiveX = -2.2;
      }

      xValue = theEffectiveX / 2.2 * -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Expanded(
              child: AnimatedContainer(
            color: Colors.black,
            duration: Duration(milliseconds: 1000),
            alignment: Alignment(this.xValue, 0.3),
            child: GameImage(),
          )),
        ],
      ),
    );
  }
}
