import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:website/screens/home/name.dart';
import 'package:website/screens/home/social_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// - gives the dx position of the screen;
  /// use [_trackCursonMovement] for this to work
  double x = 0.0;

  /// - gives the dy position of the screen;
  /// use [_trackCursonMovement] for this to work
  double y = 0.0;

  /// padding of the center name
  ///
  /// - namePaddingfromLTRB[0] is left
  /// - namePaddingfromLTRB[1] is top
  /// - namePaddingfromLTRB[2] is right
  /// - namePaddingfromLTRB[3] is bottom
  List<double> namePaddingfromLTRB = [0.0, 0.0, 0.0, 0.0];

  var _started = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _started = true;
      });
    });
  }

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
        // Tracking the curson
        child: _trackCursonMovement(
          height: height,
          width: width,
          child: Stack(
            children: [
              // water floating at the bottom
              RiveAnimation.asset(
                'assets/rive/water-home.riv',
                artboard: height > width ? 'mobile' : 'pc',
                fit: BoxFit.fill,
              ),
              // 5 social icons with box and animations
              Positioned(
                bottom: height > width ? height * 0.1 : height * 0.03,
                child: Container(
                  color: Colors.transparent,
                  width: width,
                  child: const SocialIcons(),
                ),
              ),
              // name widget, includes s logo rotation when hover
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      namePaddingfromLTRB[0],
                      namePaddingfromLTRB[1],
                      namePaddingfromLTRB[2],
                      namePaddingfromLTRB[3]),
                  child: const Name(),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: height > width ? width * 0.8 : width * 0.45,
                  height: height > width ? height * 0.3 : height * 0.4,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: RiveAnimation.asset(
                          'assets/rive/water-home.riv',
                          artboard: 'board',
                          fit: height > width ? BoxFit.fill : BoxFit.cover,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                      Positioned(
                        bottom: height > width ? height * 0.06 : height * 0.1,
                        width: height > width ? width * 0.8 : width * 0.45,
                        child: AnimatedOpacity(
                          opacity: _started ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          child: SizedBox(
                            width: height > width ? width * 0.8 : width * 0.4,
                            // redirection to previous site
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Site Under Construction..',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Please visit',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () => _launchURL(
                                            'https://immadisairaj.github.io/CarouselPortfolio'),
                                        child: const Text('here'),
                                      ),
                                    ),
                                    const Text(
                                      'for previous site.',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// updates [x] and [y] taking input of [event]
  void _onHoverUpdate(PointerEvent event) {
    setState(() {
      x = event.position.dx;
      y = event.position.dy;
      _updateNamePadding(x: x, y: y);
    });
  }

  /// updates padding of name and avatar
  ///
  /// this uses input of [x] and [y] - position of cursor
  ///
  /// automatically called from [_onHoverUpdate]
  void _updateNamePadding({x = 0.0, y = 0.0}) {
    double yCenter = MediaQuery.of(context).size.height / 2;
    double xCenter = MediaQuery.of(context).size.width / 2;

    // scale of which the padding should move
    // this should take care for the widget to not overflow
    double scale = 0.1;

    if (y < yCenter) {
      namePaddingfromLTRB[1] = (yCenter - y) * scale;
    } else if (y > yCenter) {
      namePaddingfromLTRB[3] = (y - yCenter) * scale;
    } else {
      namePaddingfromLTRB[1] = 0.0;
      namePaddingfromLTRB[3] = 0.0;
    }

    if (x < xCenter) {
      namePaddingfromLTRB[0] = (xCenter - x) * scale;
    } else if (x > xCenter) {
      namePaddingfromLTRB[2] = (x - xCenter) * scale;
    } else {
      namePaddingfromLTRB[0] = 0.0;
      namePaddingfromLTRB[2] = 0.0;
    }
  }

  /// returns empty widget provide the [height] and [width] to track
  /// cursor in computer when hovered
  ///
  /// updates [x] and [y]
  ///
  /// To track efficiently, use this on top of tree;
  Widget _trackCursonMovement(
      {required double height, required double width, required child}) {
    return Container(
      color: Colors.transparent,
      height: height,
      width: width,
      child: MouseRegion(
        onHover: _onHoverUpdate,
        child: child,
      ),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
