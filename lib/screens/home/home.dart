import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/screens/home/name.dart';
import 'package:website/screens/home/social_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.onAboutPress});

  final VoidCallback onAboutPress;

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

  /// variable which is false first and set to true after 3 second
  ///
  /// this is to ensure the text is loaded after the animation
  ///
  /// used with Animated widgets
  var _started = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _started = true;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    // precache image when going to next page (about)
    precacheImage(const AssetImage('assets/rajendra.jpeg'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                        bottom: height > width ? height * 0.065 : height * 0.11,
                        width: height > width ? width * 0.8 : width * 0.45,
                        child: AnimatedScale(
                          scale: _started ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: width * 0.08),
                                child: ElevatedButton(
                                  onPressed: () => widget.onAboutPress(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE39356),
                                    shadowColor: Colors.black,
                                    elevation: 8,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      'About',
                                      style: GoogleFonts.robotoMono(
                                        fontSize: height > width
                                            ? width * 0.04
                                            : width * 0.02,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: width * 0.08),
                                child: ElevatedButton(
                                  onPressed: () => _launchURL(
                                      'https://immadisairaj.dev/blog'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFE39356),
                                    shadowColor: Colors.black,
                                    elevation: 8,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      'Blog',
                                      style: GoogleFonts.robotoMono(
                                        fontSize: height > width
                                            ? width * 0.04
                                            : width * 0.02,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
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
            ],
          ),
        ),
      ),
    );
  }

  /// updates [x] and [y] taking input of [event]
  void _onHoverUpdate(PointerEvent event) {
    if (mounted) {
      setState(() {
        x = event.position.dx;
        y = event.position.dy;
        _updateNamePadding(x: x, y: y);
      });
    }
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
}

void _launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
