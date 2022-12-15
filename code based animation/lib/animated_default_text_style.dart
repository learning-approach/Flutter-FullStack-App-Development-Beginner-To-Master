import 'package:flutter/material.dart';

class AnimatedDefaultTextStyleFlutter extends StatefulWidget {
  @override
  State<AnimatedDefaultTextStyleFlutter> createState() =>
      _AnimatedDefaultTextStyleFlutterState();
}

class _AnimatedDefaultTextStyleFlutterState
    extends State<AnimatedDefaultTextStyleFlutter> {
  bool _first = true;
  double _fontSize = 35;
  Color _color = Colors.green;
  double _height = 100;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              _fontSize = _first ? 40 : 35;
              _color = _first ? Colors.green : Colors.blue;
              _height = _first ? 100 : 130;
              _first = !_first;
            });
          },
          child: AnimatedDefaultTextStyle(
            curve: Curves.linear,
            duration: const Duration(seconds: 5),
            style: TextStyle(
              fontSize: _fontSize,
              color: _color,
              fontWeight: FontWeight.bold,
            ),
            child: const Text("Learning-Approach"),
          ),
        ),
      ),
    );
  }
}
