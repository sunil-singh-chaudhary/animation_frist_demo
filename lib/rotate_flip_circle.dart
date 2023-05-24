import 'package:flutter/material.dart';
import 'dart:math' show pi;

enum CircleSIde { left, right }

class FlipAndRotateCircle extends StatefulWidget {
  const FlipAndRotateCircle({super.key});

  @override
  State<FlipAndRotateCircle> createState() => _FlipAndRotateCircleState();
}

class _FlipAndRotateCircleState extends State<FlipAndRotateCircle>
    with TickerProviderStateMixin {
  late AnimationController _animationControllerClockwise;
  late AnimationController _flipController;

  late Animation<double> _animationclockwise;
  late Animation<double> _flipanimation;
  @override
  void initState() {
    super.initState();
    //controller
    _animationControllerClockwise = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    //animations
    _animationclockwise = Tween<double>(begin: 0, end: -(pi / 2)).animate(
        CurvedAnimation(
            parent: _animationControllerClockwise, curve: Curves.bounceOut));
    _animationControllerClockwise.forward();

    //Flip ANimation
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipanimation = Tween<double>(begin: 0, end: pi).animate(
        CurvedAnimation(parent: _flipController, curve: Curves.bounceOut));

    //status check on complete

    _animationControllerClockwise.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipanimation = Tween<double>(
                begin: _flipanimation.value, end: _flipanimation.value + pi)
            .animate(
          CurvedAnimation(
            parent: _flipController,
            curve: Curves.bounceOut,
          ),
        );
        _flipController
          ..reset()
          ..forward();
      }
    });

    //restart
    _flipController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationclockwise = Tween<double>(
                  begin: _animationclockwise.value,
                  end: _animationclockwise.value + -(pi / 2))
              .animate(
            CurvedAnimation(
              parent: _animationControllerClockwise,
              curve: Curves.bounceOut,
            ),
          );
          _animationControllerClockwise
            ..reset()
            ..forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationControllerClockwise.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationControllerClockwise //rebuild then start from 0
      ..reset()
      ..forward.delayed(const Duration(
          seconds: 1)); //void return that why used forward not forward()

    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 2,
        title: const Text('Rotate And Flip Animation'),
      ),
      body: AnimatedBuilder(
        animation: _animationclockwise,
        builder: (context, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateZ(_animationclockwise.value),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _flipanimation,
                builder: (context, child) => Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()..rotateY(_flipanimation.value),
                  child: ClipPath(
                    clipper: HalfCirclClipper(side: CircleSIde.left),
                    child: Container(
                      color: Colors.green,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _flipanimation,
                builder: (context, child) => Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()..rotateY(_flipanimation.value),
                  child: ClipPath(
                    clipper: HalfCirclClipper(side: CircleSIde.right),
                    child: Container(
                      color: Colors.yellow,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HalfCirclClipper extends CustomClipper<Path> {
  CircleSIde side;
  HalfCirclClipper({
    required this.side,
  });
  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

extension ToPath on CircleSIde {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockwise;
    switch (this) {
      case CircleSIde.left:
        path.moveTo(size.width, 0); // start circle arc form top right to
        offset = Offset(
            size.width, size.height); //bottomright complet arc [position]
        clockwise = false; //anitclockwise moving

        break;
      case CircleSIde.right:
        // path.moveTo(x, y )  not do because it already moved to the position from where we create next arc
        offset = Offset(0, size.height);
        clockwise = true;

        break;
    }
    path.arcToPoint(
      clockwise: clockwise,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      offset,
    );
    path.close();
    return path;
  }
}

extension on VoidCallback {
  //return void
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

// extension on CircleSIde {
//   Path toPATH(Size size) {
//     var path = Path();
//     var offset;
//     var clockwise;

//     switch (this) {
//       case CircleSIde.left:
//         path.moveTo(size.width, 0);
//         clockwise = false;
//         offset = Offset(size.width, size.height);
//         break;
//       case CircleSIde.right:
//         clockwise = true;
//         offset = Offset(0, size.height);
//         break;
//     }
//     path.arcToPoint(
//       clockwise: clockwise,
//       radius: Radius.elliptical(size.width / 2, size.height / 2),
//       offset,
//     );
//   path.close();
//     return path;
//   }
// }
