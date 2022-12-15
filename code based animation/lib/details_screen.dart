import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  String img;
  int heroTag;
  DetailsScreen(this.img, this.heroTag);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: heroTag,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                  img,
                ),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
