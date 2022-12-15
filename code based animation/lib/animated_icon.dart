import 'package:flutter/material.dart';

class AnimatedIconFlutter extends StatefulWidget {
  @override
  State<AnimatedIconFlutter> createState() => _AnimatedIconFlutterState();
}

class _AnimatedIconFlutterState extends State<AnimatedIconFlutter>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  bool videoPlaying = false;
  changePlayer() {
    if (videoPlaying == false) {
      _animationController!.forward();
      videoPlaying = true;
    } else {
      _animationController!.reverse();
      videoPlaying = false;
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: InkWell(
          onTap: () => changePlayer(),
          child: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            size: 200,
            color: Colors.green,
            progress: _animationController!,
          ),
        ),
      ),
    );
  }
}
