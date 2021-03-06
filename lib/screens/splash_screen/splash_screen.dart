import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.onHomeNav}) : super(key: key);

  final VoidCallback onHomeNav;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      widget.onHomeNav();
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
