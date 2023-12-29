import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onHomeNav});

  final VoidCallback onHomeNav;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
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
