import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// gives the dx position of the screen
  ///
  /// use [_trackCursonMovement] for this to work
  double x = 0.0;

  /// gives the dy position of the screen
  ///
  /// use [_trackCursonMovement] for this to work
  double y = 0.0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // /// is true when the platform is on mobile
    // bool isWebMobile = kIsWeb &&
    //     (defaultTargetPlatform == TargetPlatform.iOS ||
    //         defaultTargetPlatform == TargetPlatform.android);

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
                          fontSize: width * 0.08),
                    ),
                  ),
                ],
              ),
            ),
            // Tracking the curson or touch
            _trackCursonMovement(height: height, width: width),
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

  /// updates [x] and [y] taking input of [event]
  void _onHoverUpdate(PointerEvent event) {
    setState(() {
      x = event.position.dx;
      y = event.position.dy;
    });
  }

  /// returns empty widget provide the [height] and [width] to track
  /// - cursor - in computer when hovered
  /// - touch movement - in mobile when touch
  ///
  /// updates [x] and [y]
  ///
  /// To track efficiently, use this on top of stack;
  /// ensure there is no other event below this layer (like click)
  Widget _trackCursonMovement({required double height, required double width}) {
    /// is true when the platform is on mobile
    bool isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    // TODO: remove x = dx, y = dy later

    return Container(
      color: Colors.transparent,
      height: height,
      width: width,
      child: !isWebMobile
          ? MouseRegion(
              onHover: _onHoverUpdate,
              child: Container(
                color: Colors.transparent,
                child: Text(
                  'x = ${x.toString()}, y = ${y.toString()}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : Listener(
              onPointerMove: _onHoverUpdate,
              child: Container(
                color: Colors.transparent,
                child: Text(
                  'x = ${x.toString()}, y = ${y.toString()}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
