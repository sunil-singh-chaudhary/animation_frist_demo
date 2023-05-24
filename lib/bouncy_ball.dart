import 'package:flutter/material.dart';

class BouncyBall extends StatefulWidget {
  const BouncyBall({Key? key}) : super(key: key);

  @override
  State<BouncyBall> createState() => _BouncyBallState();
}

class _BouncyBallState extends State<BouncyBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  late double dx = -50;
  late double dy = 200;
  int roundCount = 1;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: dx, end: dy).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.reverse) {
    //     handleIncrement().;
    //     _animationController.repeat();
    //   }
    // });
    handleIncrement();
    super.initState();
  }

  void handleIncrement() {
    do {
      _animationController
          .forward()
          .then((value) => _animationController.reverse().then((value) {
                roundCount++;
                dx = dx + (roundCount * 10);
                _animation = Tween<double>(begin: dx, end: dy)
                    .animate(_animationController)
                  ..addListener(() {});
              }));
    } while (roundCount <= 20);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("COUNT--> $roundCount");
    return Scaffold(
      appBar: AppBar(title: const Text("Bouncy Ball")),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.translate(
          offset: Offset(100, _animation.value),
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
