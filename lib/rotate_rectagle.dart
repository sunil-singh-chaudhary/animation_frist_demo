import 'package:flutter/material.dart';
import 'dart:math' show pi;

class RotateRetangle extends StatefulWidget {
  const RotateRetangle({super.key});

  @override
  State<RotateRetangle> createState() => _RotateRetangleState();
}

class _RotateRetangleState extends State<RotateRetangle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    //animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    //type of animation
    _animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    //animation movement
    _animationController.repeat();
  }

  @override
  void dispose() {
    //disponse animation
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Move Rectangle"),
      ),
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateZ(_animation.value),
          child: Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
