import 'package:flutter/material.dart';

class AnimatedContainerFlutter extends StatefulWidget {
  @override
  State<AnimatedContainerFlutter> createState() =>
      _AnimatedContainerFlutterState();
}

class _AnimatedContainerFlutterState extends State<AnimatedContainerFlutter> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              value =! value;
            });
          },
          child: AnimatedContainer(
            height: value == true ? 200 : 300,
            width: value == true ? 200 : 300,
            curve: Curves.bounceIn,
            color: value == true ? Colors.amberAccent : Colors.green,
            duration: Duration(
              seconds: 3,
            ),
          ),
        ),
      ),
    );
  }
}
