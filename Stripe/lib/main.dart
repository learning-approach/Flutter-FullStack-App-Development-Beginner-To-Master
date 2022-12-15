import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:learning_approach/recent.dart';
import 'package:learning_approach/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51M5Ei2IGm0dQSaCMGhNKfosCfIzJNeDqh4gjHvCGQgGC3gnpELF0AgzDMSW5pHLFn5FSrbVFrbxROCnao3RnZP7h00AwmMHRyF';
  await Stripe.instance.applySettings();
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
      routes: {'recent': (context) => RecentlyUploadedItems()},
    );
  }
}
