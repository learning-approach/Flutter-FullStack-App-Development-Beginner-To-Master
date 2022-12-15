import 'package:flutter/material.dart';
import 'package:learning_approach/pages/account.dart';
import 'package:learning_approach/pages/add.dart';
import 'package:learning_approach/pages/chat.dart';
import 'package:learning_approach/pages/home_nav.dart';
import 'package:learning_approach/pages/my_ads.dart';

class BottomNavController extends StatefulWidget {
  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _currentIndex = 0;
  final _pages = [
    Home(),
    MyAds(),
    Add(),
    Chat(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF5364F4),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'My Ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
      body: _pages[_currentIndex],
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text('learning-approach'),
      //   backgroundColor: Color(0xFF5364F4),
      // ),
    );
  }
}
