import 'package:flutter/material.dart';
import 'tabs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(seconds: 5));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _controller?.forward();

    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const TabsScreen()));
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation!,
        builder: (context, child) {
          return Opacity(
            opacity: _animation!.value,
            child: const Center(
              child: Text('Bienvenue dans Mon App',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.red,
                  )),
            ),
          );
        },
      ),
    );
  }
}
