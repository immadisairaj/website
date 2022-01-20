import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF194D54),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: width * 0.07,
                    // backgroundColor: Colors.transparent,
                    backgroundColor: const Color(0xFF42C9DB),
                    foregroundImage: const AssetImage('assets/logo.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ai Rajendra Immadi',
                      style: TextStyle(
                          color: const Color(0xFF42C9DB),
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.07),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: height * 0.1,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Site Under Construction..',
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Please visit',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _launchURL(
                              'https://immadisairaj.github.io/carousel-portfolio'),
                          child: const Text('here'),
                        ),
                      ),
                      const Text(
                        'for previous site.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
