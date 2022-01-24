import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'package:url_launcher/url_launcher.dart';

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

  /// boolean value for logo rotation animation
  /// - _logoHover?.value = true; to rotate
  /// - _logoHover?.value = false; to stop rotating
  SMIBool? _logoHover;

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
                'assets/rive/water-floating.riv',
                artboard: height > width ? 'mobile' : 'pc',
                fit: BoxFit.fill,
              ),
              // name widget, includes s logo rotation when hover
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
                      MouseRegion(
                        onEnter: (event) => _logoHover?.value = true,
                        onExit: (event) => _logoHover?.value = false,
                        child: CircleAvatar(
                          radius: width * 0.07,
                          // backgroundColor: Colors.transparent,
                          backgroundColor: const Color(0xFF42C9DB),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RiveAnimation.asset(
                              'assets/rive/s-logo-rotation.riv',
                              fit: BoxFit.cover,
                              onInit: _onLogoRotationInit,
                            ),
                          ),
                          // foregroundImage: const AssetImage('assets/logo.png'),
                        ),
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
              // redirection to previous site
              Positioned(
                bottom: height * 0.05,
                width: width,
                child: Opacity(
                  opacity: 0.7,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// initializes the logo rotation rive animation
  ///
  /// load from asset/rive/s-logo-rotation.riv
  void _onLogoRotationInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'rotate');
    artboard.addController(controller!);
    _logoHover = controller.findInput<bool>('Hover') as SMIBool;
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
