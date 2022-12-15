import 'package:flutter/material.dart';
import 'package:learning_approach/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'learning-approach',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF4F5F7),
      ),
      home: Splash(),
    );
  }
}
