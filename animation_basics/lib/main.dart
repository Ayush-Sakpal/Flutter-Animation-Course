import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // HomePage is a widget that is re-drawn at our screen at the refresh rate of our screen.
  // Higher screen refresh rate => Faster the widgets are drawn on the screen.

  /*
    In development terms, refresh rate is called Vertical Sync (vsync).
    This is because the screen refreshes from top to bottom(and left to right).
   */

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // There are two types of mixin: SingleTickerProviderStateMixin and TickerProviderStateMixin

  // Animation Controller -> 0.0 to 1.0
  // We bind Animation to Animation Controller so that we can use values as per our requirements.
  /*
    Animation Controller  |   Animation
    ---------------------------------------------
          0.0             |   0 degrees
          0.5             |   180 degrees
          1.0             |   360 degrees
  */

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation =
        Tween<double>(begin: 0.0, end: 2 * pi).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center, // This is basically a Pivot-point
                transform: Matrix4.identity()..rotateY(
                    _animation.value
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 11,
                            blurRadius: 11,
                            offset: const Offset(0, 3))
                      ]),
                ),
              );
            }),
      ),
    );
  }
}
