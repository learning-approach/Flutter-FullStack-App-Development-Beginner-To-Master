import 'dart:io';
import 'package:chatapp/ui/route/route.dart';
import 'package:chatapp/ui/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    name: "chatapp",
    options: Platform.isAndroid
        ? FirebaseOptions(
            apiKey: "AIzaSyB2cTzY6CbQT6v0fyGQDQsIrF_zhAkIHEg",
            appId: "1:132106542439:android:eaa8327b77867de77fe3c2",
            messagingSenderId: "132106542439",
            projectId: "chat-app-bd883",
          )
        : FirebaseOptions(
            apiKey: "AIzaSyDHP0hfttdU2Ze4oCEmvn_5exbGxzwYxzc",
            appId: "1:132106542439:ios:47f1158cd3a1ae097fe3c2",
            messagingSenderId: "132106542439",
            projectId: "chat-app-bd883",
          ),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        // Otherwise, show something while waiting for initialization to complete
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          initialRoute: splash,
          getPages: getPages,
          home: SplashScreen(),
        );
      },
    );
  }
}
