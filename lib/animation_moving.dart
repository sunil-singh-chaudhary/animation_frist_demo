import 'package:flutter/material.dart';

class LeftToRightAnimation extends StatefulWidget {
  const LeftToRightAnimation({super.key});

  @override
  State<LeftToRightAnimation> createState() => _LeftToRightAnimationState();
}

class _LeftToRightAnimationState extends State<LeftToRightAnimation>
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
        Tween<double>(begin: -200, end: 200).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    //animation movement
    _animationController.repeat(reverse: true);
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
        child: Transform.translate(
          offset: Offset(_animation.value, 0),
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
