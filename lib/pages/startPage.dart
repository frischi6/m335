import 'package:flutter/material.dart';
import 'package:m335/pages/gamePage.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyStartPage(title: 'Game Target'),
    );
  }
}

class MyStartPage extends StatefulWidget {
  const MyStartPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyStartPage> createState() => _MyStartPage();
}

class _MyStartPage extends State<MyStartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Target')),
      body: Column(
        children: [
          ElevatedButton(
              child: Text('Play in Space World'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return GamePage(chosenWorld: 0);
                  }),
                );
              }),
          ElevatedButton(
              child: Text('Play in Soccer World'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return GamePage(chosenWorld: 1);
                  }),
                );
              }),
        ],
      ),
    );
  }
}
