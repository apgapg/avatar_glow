import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avatar Glow Demo',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _animate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avatar Glow by @apgapg"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(32.0),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                AvatarGlow(
                  animate: _animate,
                  child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 30,
                      child: Image.asset(
                        'assets/images/dart.png',
                        height: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                AvatarGlow(
                  startDelay: const Duration(milliseconds: 1000),
                  glowColor: Colors.white,
                  glowShape: BoxShape.circle,
                  animate: _animate,
                  curve: Curves.fastOutSlowIn,
                  child: const Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                      radius: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              AvatarGlow(
                animate: _animate,
                glowColor: Colors.red,
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 40.0,
                    child: Image.asset(
                      'assets/images/flutter.png',
                      height: 60,
                    ),
                  ),
                ),
              ),
              AvatarGlow(
                animate: _animate,
                glowColor: Colors.red,
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 40.0,
                    child: Image.asset(
                      'assets/images/love.png',
                      height: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          AvatarGlow(
            animate: _animate,
            glowColor: Colors.cyan,
            child: Material(
              elevation: 8.0,
              shape: const CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 30.0,
                child: Image.asset(
                  'assets/images/dart.png',
                  height: 50,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AvatarGlow(
        animate: _animate,
        glowColor: Colors.red,
        child: IconButton(
          onPressed: () {
            setState(() => _animate = !_animate);
          },
          iconSize: 42.0,
          icon: Icon(
            _animate ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
      ),
    );
  }
}
