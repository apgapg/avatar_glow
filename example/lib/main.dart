import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avatar Glow Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _animate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Glow by @apgapg"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Color(0xff686de0),
              child: AvatarGlow(
                endRadius: 70,
                animate: _animate,
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Image.asset(
                      'assets/images/dart.png',
                      height: 50,
                    ),
                    radius: 30,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Color(0xff686de0),
              child: AvatarGlow(
                startDelay: Duration(milliseconds: 1000),
                glowColor: Colors.white,
                endRadius: 100.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  color: Colors.transparent,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 50.0,
                  ),
                ),
                shape: BoxShape.circle,
                animate: true,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: 90.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Image.asset(
                        'assets/images/flutter.png',
                        height: 60,
                      ),
                      radius: 40.0,
                    ),
                  ),
                ),
                AvatarGlow(
                  glowColor: Colors.red,
                  endRadius: 90.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Image.asset(
                        'assets/images/love.png',
                        height: 60,
                      ),
                      radius: 40.0,
                    ),
                  ),
                ),
              ],
            ),
            AvatarGlow(
              glowColor: Colors.cyan,
              endRadius: 60.0,
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: Material(
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: Image.asset(
                    'assets/images/dart.png',
                    height: 50,
                  ),
                  radius: 30.0,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _animate = !_animate;
          });
        },
      ),
    );
  }
}
