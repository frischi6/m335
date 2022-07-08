import 'package:better_sound_effect/better_sound_effect.dart';
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
  int? soundId;
  final soundEffect = BetterSoundEffect();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      soundId = await soundEffect.loadAssetAudioFile("sounds/sound.mp3");
    });
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
                if (soundId != null) {
                  soundEffect.play(soundId!);
                }
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
                if (soundId != null) {
                  soundEffect.play(soundId!);
                }
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
