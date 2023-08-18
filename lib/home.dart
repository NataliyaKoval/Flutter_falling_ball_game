import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _circleSize = 20;
  late double _xPosition;
  double _yPosition = 0;
  late double _centerY;
  late Timer timerOnStart;
  Timer? timerOnDown;
  Timer? timerOnUp;
  int taps = 0;

  @override
  void initState() {
    super.initState();
    _throwBall();
  }

  @override
  Widget build(BuildContext context) {
    _xPosition = (MediaQuery.of(context).size.width - _circleSize) / 2;
    _centerY = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(taps.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTapDown: (TapDownDetails details) => _changeDirection(details),
              child: Container(
                color: Colors.yellow,
              ),
            ),
            Positioned(
              left: _xPosition,
              top: _yPosition,
              child: Container(
                width: _circleSize,
                height: _circleSize,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _throwBall() {
    const duration = Duration(milliseconds: 10);
    timerOnStart = Timer.periodic(duration, (Timer t) {
      setState(() {
        _yPosition += 1;
      });
    });
  }

  void _changeDirection(TapDownDetails details) {
    taps += 1;
    const duration = Duration(milliseconds: 10);
    if (details.globalPosition.dy >= _centerY) {
      _cancelTimers();
      timerOnUp = Timer.periodic(duration, (Timer t) {
        setState(() {
          _yPosition -= 1;
        });
      });
    } else {
      _cancelTimers();
      timerOnDown = Timer.periodic(duration, (Timer t) {
        setState(() {
          _yPosition += 1;
        });
      });
    }
  }

  void _cancelTimers() {
    timerOnStart.cancel();
    timerOnUp?.cancel();
    timerOnDown?.cancel();
  }
}
