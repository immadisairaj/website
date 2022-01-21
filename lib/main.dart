import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:website/screens/home/home.dart';
import 'package:website/screens/splash_screen/splash_screen.dart';

void main() {
  // sets the url strategy for web-pages as
  // website/path instead of website/#/path
  setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // remove debug checker
      debugShowCheckedModeBanner: false,
      title: 'immadisairaj',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const SplashScreen(),
    );
  }
}
