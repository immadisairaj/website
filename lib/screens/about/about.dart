import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isLandscape = height < width;
    const Widget logo = RiveAnimation.asset(
      'assets/rive/s-logo-rotation.riv',
      fit: BoxFit.fitHeight,
    );
    return Scaffold(
      backgroundColor: const Color(0xFF194D54),
      body: AnimatedBackground(
        vsync: this,
        behaviour: SpaceBehaviour(
          backgroundColor: Colors.transparent,
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          // redirect to previous site
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: isLandscape ? null : height * 0.3,
              floating: true,
              stretch: isLandscape ? false : true,
              leading: isLandscape
                  ? const Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, top: 10, bottom: 10, right: 0),
                      child: logo,
                    )
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: isLandscape ? false : true,
                title: Text(
                  'Sai Rajendra Immadi',
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                background: isLandscape ? null : logo,
                stretchModes: const [
                  StretchMode.fadeTitle,
                  StretchMode.zoomBackground,
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height,
                child: Center(
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
                                  'https://immadisairaj.github.io/CarouselPortfolio'),
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
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
