import 'package:flutter/material.dart';

class AnimtedContainerWithList extends StatefulWidget {
  const AnimtedContainerWithList({super.key});

  @override
  State<AnimtedContainerWithList> createState() =>
      _AnimtedContainerWithListState();
}

class _AnimtedContainerWithListState extends State<AnimtedContainerWithList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  bool startAnimation = false;
  double screenHeight = 0;
  double screenWidth = 0;
  final list = [
    'SUNIL',
    'SINGH',
    'Chaudhary',
    'Rocky',
    'Balboa',
    'COntainer',
    'SUNIL',
    'SINGH',
    'Chaudhary',
    'Rocky',
    'Balboa',
    'COntainer',
    'SUNIL',
    'SINGH',
    'Chaudhary',
    'Rocky',
    'Balboa',
    'COntainer',
  ];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          startAnimation = true;
        });
      },
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            key: _key,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 60,
                child: AnimatedContainer(
                  margin: const EdgeInsets.all(4),
                  color: Colors.green[400],
                  height: 60,
                  width: double.infinity,
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  curve: Curves.easeInOut,
                  transform: Matrix4.translationValues(
                    startAnimation ? 0 : screenWidth,
                    0,
                    0,
                  ),
                  child: Center(
                    child: Text(
                      "Data is--> ${list[index]}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
