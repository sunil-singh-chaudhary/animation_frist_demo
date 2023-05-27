import 'package:animation_frist_demo/hero_mode.dart';
import 'package:flutter/material.dart';

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  HeroModel mode = HeroModel(
    name: "JOhn",
    age: 12,
    icns: const Icon(Icons.add_moderator),
  );
  List<HeroModel> people = [
    HeroModel(
      name: "JOhn",
      age: 12,
      icns: const Icon(Icons.add_moderator),
    ),
    HeroModel(
      name: "DON",
      age: 22,
      icns: const Icon(Icons.ac_unit_sharp),
    ),
    HeroModel(
      name: "MOHAN",
      age: 34,
      icns: const Icon(Icons.access_time_filled_sharp),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero Animation"),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          var peopeindex = people[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(peopeindex: peopeindex),
                  ));
            },
            leading: Hero(
              tag: peopeindex.name,
              child: peopeindex.icns,
              flightShuttleBuilder: (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                switch (flightDirection) {
                  case HeroFlightDirection.push:
                    return Material(
                      color: Colors.transparent,
                      child: ScaleTransition(
                          scale: animation.drive(Tween<double>(begin: 0, end: 5)
                              .chain(CurveTween(curve: Curves.fastOutSlowIn))),
                          child: toHeroContext.widget),
                    );

                  case HeroFlightDirection.pop:
                    return Material(
                      child: fromHeroContext.widget,
                      color: Colors.transparent, //remove yellow below it
                    );
                }
              },
            ),
            title: Text(peopeindex.name.toString()),
            subtitle: Text(peopeindex.age.toString()),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  HeroModel peopeindex;

  DetailsPage({super.key, required this.peopeindex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Hero(
        tag: peopeindex.name,
        child: IconButton(
          onPressed: () {},
          icon: peopeindex.icns,
          iconSize: 30,
        ),
      ))),
    );
  }
}
