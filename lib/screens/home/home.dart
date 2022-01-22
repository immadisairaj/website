import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// - gives the dx position of the screen when on pc;
  /// use [_trackCursonMovement] for this to work
  ///
  /// - gives x rotated position of screen when on mobile;
  /// updated automatically from [initState] and [_streamSubscriptions]
  double x = 0.0;

  /// - gives the dy position of the screen when on pc;
  /// use [_trackCursonMovement] for this to work
  ///
  /// - gives y rotated position of screen when on mobile;
  /// updated automatically from [initState] and [_streamSubscriptions]
  double y = 0.0;

  // TODO: test gyro in mobile and probably remove? if not working properly

  /// gyroscope values to access. Gets data automatically from listener
  /// of [_streamSubscriptions]
  List<double>? gyroscopeValues;

  /// subscription of gyro values when in mobile
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  /// padding of the center name
  ///
  /// - namePaddingfromLTRB[0] is left
  /// - namePaddingfromLTRB[1] is top
  /// - namePaddingfromLTRB[2] is right
  /// - namePaddingfromLTRB[3] is bottom
  List<double> namePaddingfromLTRB = [0.0, 0.0, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // final gyroscope =
    //     gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();

    /// is true when the platform is on mobile
    bool isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    return Scaffold(
      backgroundColor: const Color(0xFF194D54),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    namePaddingfromLTRB[0],
                    namePaddingfromLTRB[1],
                    namePaddingfromLTRB[2],
                    namePaddingfromLTRB[3]),
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
            ),
            // Tracking the curson if on pc
            if (!isWebMobile)
              _trackCursonMovement(height: height, width: width),
            // Text(
            //   '$gyroscope\nx=$x, y=$y',
            //   style: const TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            Positioned(
              bottom: height * 0.05,
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

  @override
  void initState() {
    super.initState();

    // check if platform is web or mobile
    bool isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    // add gyro tracking only if on mobile
    if (isWebMobile) {
      _streamSubscriptions.add(
        gyroscopeEvents.listen(
          (GyroscopeEvent event) {
            setState(() {
              gyroscopeValues = <double>[event.x, event.y, event.z];
              _updateNamePaddingMobile(gyroX: event.x, gyroY: event.y);
            });
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    super.dispose();
  }

  /// updates [x] and [y] taking input of [event]
  void _onHoverUpdate(PointerEvent event) {
    setState(() {
      x = event.position.dx;
      y = event.position.dy;
      _updateNamePaddingPC(x: x, y: y);
    });
  }

  /// updates padding of name and avatar when on pc
  ///
  /// this uses input of [x] and [y] - position of cursor
  ///
  /// automatically called from [_onHoverUpdate]
  void _updateNamePaddingPC({x = 0.0, y = 0.0}) {
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

  /// updates padding of name and avatar when on mobile
  ///
  /// this uses input of [gyroX] and [gyroY]
  /// from [GyroscopeEvent]
  ///
  /// automatially called from [initState] along with
  /// [_streamSubscriptions] listener
  void _updateNamePaddingMobile({gyroX = 0, gyroY = 0}) {
    // having opposite x and y is because of the gyro in mobile
    x += gyroY;
    y += gyroX;

    // maximum height or width the padding can go
    double heightMax = MediaQuery.of(context).size.height * 0.05;
    double widthMax = MediaQuery.of(context).size.width * 0.05;

    // scale of padding
    double scale = 3;

    if (y * scale > heightMax || y * scale < -heightMax) {
      return;
    }
    if (x * scale > widthMax || x * scale < -widthMax) {
      return;
    }

    if (y < 0) {
      namePaddingfromLTRB[1] = -y * scale;
    } else if (y > 0) {
      namePaddingfromLTRB[3] = y * scale;
    } else {
      namePaddingfromLTRB[1] = 0.0;
      namePaddingfromLTRB[3] = 0.0;
    }

    if (x < 0) {
      namePaddingfromLTRB[0] = -x * scale;
    } else if (x > 0) {
      namePaddingfromLTRB[2] = x * scale;
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
  /// To track efficiently, use this on top of stack;
  /// ensure there is no other event below this layer (like click)
  Widget _trackCursonMovement({required double height, required double width}) {
    /// is true when the platform is on mobile
    bool isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    return Container(
      color: Colors.transparent,
      height: height,
      width: width,
      child: !isWebMobile
          ? MouseRegion(
              onHover: _onHoverUpdate,
              child: Container(
                  // color: Colors.transparent,
                  // child: Text(
                  //   'x = ${x.toString()}, y = ${y.toString()}',
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  ),
            )
          : Container(),
    );
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
