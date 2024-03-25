import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class Snowflake {
  double x;
  double y;
  double size;
  double fallSpeed;

  Snowflake({
    required this.x,
    required this.y,
    required this.size,
    required this.fallSpeed,
  });
}

class SnowyBackground extends StatefulWidget {
  @override
  _SnowyBackgroundState createState() => _SnowyBackgroundState();
}

class _SnowyBackgroundState extends State<SnowyBackground> {
  List<Snowflake> snowflakes = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 16), (Timer t) {
      createSnowflake();
      updateSnowflakes();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void createSnowflake() {
    final random = Random();
    snowflakes.add(Snowflake(
      x: random.nextDouble() * MediaQuery.of(context).size.width,
      y: 0,
      size: random.nextDouble() * 5 + 2,
      fallSpeed: random.nextDouble() * 2 + 1,
    ));
  }

  void updateSnowflakes() {
    setState(() {
      snowflakes = snowflakes
          .map((flake) => Snowflake(
        x: flake.x,
        y: flake.y + flake.fallSpeed,
        size: flake.size,
        fallSpeed: flake.fallSpeed,
      ))
          .where((flake) => flake.y < MediaQuery.of(context).size.height)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        ...snowflakes.map(
              (flake) => Positioned(
            left: flake.x,
            top: flake.y,
            child: Container(
              width: flake.size,
              height: flake.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}