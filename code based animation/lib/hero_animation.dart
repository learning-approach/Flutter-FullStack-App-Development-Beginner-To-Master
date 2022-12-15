import 'package:flutter/material.dart';
import 'package:learning_approach/details_screen.dart';

class HeroAnimationFlutter extends StatelessWidget {
  List<String> _places = [
    'https://adarbepari.com/wp-content/uploads/2018/12/debotakhum-bandarban-1.jpg',
    'https://t3.ftcdn.net/jpg/03/08/07/74/360_F_308077404_GZLRc6Bk9Uw8laf646emfbfFRG53HYIN.jpg',
    'https://i.pinimg.com/originals/2e/82/32/2e8232edb7980535819fb00afc168ce7.jpg',
    'https://i.pinimg.com/originals/88/58/38/8858381bd0ced28062ebd6e3cc7eabf6.png',
    'https://www.lrbtravelteam.com/wp-content/uploads/2021/03/Bandarban.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
      ),
      body: ListView.builder(
        itemCount: _places.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(_places[index],index),
                ),
              );
            },
            child: Hero(
              tag: index,
              child: Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 5,
                  bottom: 5,
                ),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                        _places[index],
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
