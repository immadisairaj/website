import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:website/screens/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.of(context).pushReplacement(HomePageTransition());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: RiveAnimation.asset(
          'assets/rive/whale-loading.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class HomePageTransition extends PageRouteBuilder {
  HomePageTransition()
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                const Home());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: const Home(),
    );
  }
}
