import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDimensionS extends StatefulWidget {
  const ThreeDimensionS({super.key});

  @override
  State<ThreeDimensionS> createState() => _ThreeDimensionSState();
}

class _ThreeDimensionSState extends State<ThreeDimensionS>
    with TickerProviderStateMixin {
  late AnimationController _XAnimationController;
  late AnimationController _YAnimationController;
  late AnimationController _ZAnimationController;

  late Tween<double> _animation;
  @override
  void initState() {
    _animation = Tween<double>(
        begin: 0,
        end: pi *
            2); //direct use tween not animation because we have x,y,z animation

    _XAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _YAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _ZAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    super.initState();
  }

  @override
  void dispose() {
    _XAnimationController.dispose();
    _YAnimationController.dispose();
    _ZAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _XAnimationController
      ..reset()
      ..repeat();
    _YAnimationController
      ..reset()
      ..repeat();
    _ZAnimationController
      ..reset()
      ..repeat();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _XAnimationController,
                _YAnimationController,
                _ZAnimationController
              ]),
              builder: (context, child) => Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_XAnimationController))
                  ..rotateY(_animation.evaluate(_YAnimationController))
                  ..rotateZ(_animation.evaluate(_ZAnimationController)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //front screen
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.amber,
                    ),
                    //back
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(Vector3(0, 0, -100)), //move screen back 100
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.green,
                      ),
                    ),
                    //left screen
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.orange,
                      ),
                    ),
                    //right side
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.blue,
                      ),
                    ),
                    Transform(
                      //move it to other position to make it shape of S
                      alignment: Alignment.topLeft,
                      transform: Matrix4.identity()
                        ..translate(Vector3(0, 0, 100)),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
