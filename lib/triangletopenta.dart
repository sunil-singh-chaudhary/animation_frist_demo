import 'dart:math';

import 'package:flutter/material.dart';

class TriangleToDiffShapeAnimation extends StatefulWidget {
  const TriangleToDiffShapeAnimation({super.key});

  @override
  State<TriangleToDiffShapeAnimation> createState() =>
      _TriangleToDiffShapeAnimationState();
}

class polygon extends CustomPainter {
  int side;
  polygon({required this.side});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap
              .round //end point of two line intersacts will be a point of round shape
        ;
    final center = Offset(size.width / 2, size.height / 2);
    final angle = (2 * pi) / side;
    final angles = List.generate(side, (index) => angle * index);
    final radius = size.width / 2;

    /*
     move pointer to side from center so we can draw form there 
     x=center.x+radius+cos(angle)
     y=center.y+radius+sin(angle)
    */

    final path = Path();
    path.moveTo(center.dx + radius * cos(0), center.dy + radius * sin(0));

    for (final angle in angles) {
      path.lineTo(
          center.dx + radius * cos(angle), center.dy + radius * sin(angle));
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is polygon && oldDelegate.side != side;
  }
}

class _TriangleToDiffShapeAnimationState
    extends State<TriangleToDiffShapeAnimation> with TickerProviderStateMixin {
  late AnimationController _sideController;
  late AnimationController _radiusController;

  late AnimationController _rotationController;
  late Animation<int> _sideAnimation;

  late Animation<double> _radiusAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _sideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _sideAnimation = IntTween(
      begin: 3,
      end: 10,
    ).animate(_sideController);
    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _radiusAnimation = Tween<double>(
      begin: 20.0,
      end: 400.0,
    ).chain(CurveTween(curve: Curves.bounceInOut)).animate(_radiusController);
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: (2 * pi),
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_rotationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sideController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
    _rotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _sideController.dispose();
    _radiusController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _sideController,
            _radiusController,
            _rotationController,
          ]),
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(_rotationAnimation.value)
              ..rotateY(_rotationAnimation.value)
              ..rotateZ(_rotationAnimation.value),
            child: CustomPaint(
              painter: polygon(side: _sideAnimation.value),
              child: SizedBox(
                height: _radiusAnimation.value,
                width: _radiusAnimation.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
