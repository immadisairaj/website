import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/screens/about/bio.dart';
import 'package:website/widgets/page_status.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  /// scroll controller for the whole page
  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);

  /// provides the percentage of page scrolled to the [PageStatus] widget
  double _pageLevel = 0;

  /// controller that drives logo scale animation when in landscape
  late AnimationController _logoAnimationController;
  late Animation<double> _logoScale;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _logoScale = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.hasClients) {
      var max = _scrollController.position.maxScrollExtent;
      var current = _scrollController.offset;
      setState(() {
        _pageLevel = (current / max) * 100;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isLandscape = height < width;

    const Widget logo = RiveAnimation.asset(
      'assets/rive/s-logo-rotation.riv',
      fit: BoxFit.fitHeight,
    );
    double contentWidth = width * 0.8;

    return Scaffold(
      backgroundColor: const Color(0xFF194D54),
      body: AnimatedBackground(
        vsync: this,
        behaviour: SpaceBehaviour(
          backgroundColor: Colors.transparent,
        ),
        child: Stack(
          children: [
            Scrollbar(
              isAlwaysShown: true,
              controller: _scrollController,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: isLandscape ? null : height * 0.3,
                    floating: true,
                    stretch: isLandscape ? false : true,
                    leading: isLandscape
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 10, bottom: 10, right: 0),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  _logoAnimationController.forward(),
                              onExit: (_) => _logoAnimationController.reverse(),
                              child: ScaleTransition(
                                scale: _logoScale,
                                child: GestureDetector(
                                  child: logo,
                                  onTap: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                            ),
                          ),
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
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Bio(
                            screenHeight: height,
                            screenWidth: width,
                          ),
                          // redirect to old site
                          SizedBox(
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              height: height * 0.1,
              width: width,
              child: PageStatus(
                key: isLandscape
                    ? const Key('landscape_about_page_status')
                    : const Key('portrait_about_page_status'),
                level: _pageLevel,
                isLandscape: isLandscape,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
