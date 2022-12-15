import 'package:flutter/material.dart';
import 'package:learning_approach/animated_container.dart';
import 'package:learning_approach/animated_default_text_style.dart';
import 'package:learning_approach/animated_icon.dart';
import 'package:learning_approach/animated_opacity.dart';
import 'package:learning_approach/animated_positioned.dart';
import 'package:learning_approach/hero_animation.dart';

class Example extends StatefulWidget {
  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'learning-approach',
          style: TextStyle(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AnimatedIconFlutter(),
                  ),
                ),
                child: Text('Animated Icon'),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AnimatedContainerFlutter(),
                  ),
                ),
                child: Text('Animated Container'),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AnimatedDefaultTextStyleFlutter(),
                  ),
                ),
                child: Text('Animated Default Text Style'),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AnimatedPositionedFlutter(),
                  ),
                ),
                child: Text('Animated Positioned'),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AnimatedOpacityFlutter(),
                  ),
                ),
                child: Text('Animated Opacity'),
              ),
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HeroAnimationFlutter(),
                  ),
                ),
                child: Text('Hero'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
