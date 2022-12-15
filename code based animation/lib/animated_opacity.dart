import 'package:flutter/material.dart';

class AnimatedOpacityFlutter extends StatefulWidget {
  @override
  State<AnimatedOpacityFlutter> createState() => _AnimatedOpacityFlutterState();
}

class _AnimatedOpacityFlutterState extends State<AnimatedOpacityFlutter> {
  double _opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(
                seconds: 3,
              ),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Slider(
              value: _opacity,
              onChanged: (onChanged) {
                setState(() {
                  _opacity = onChanged;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
