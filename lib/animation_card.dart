import 'package:flutter/material.dart';

class SimpleFadeInAnimation extends StatefulWidget {
  const SimpleFadeInAnimation({super.key});

  @override
  State<SimpleFadeInAnimation> createState() => _SimpleFadeInAnimationState();
}

class _SimpleFadeInAnimationState extends State<SimpleFadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animation")),
      body: Center(
          child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
          );
        },
      )),
    );
  }
}
