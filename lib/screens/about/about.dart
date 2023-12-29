import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/constants/constants.dart';
import 'package:website/screens/about/bio.dart';
import 'package:website/screens/about/projects.dart';
import 'package:website/screens/home/social_icons_about.dart';
import 'package:website/widgets/other_links.dart';
import 'package:website/widgets/page_status.dart';
import 'package:website/widgets/rnn_youtube.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
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
    // double contentWidth = width * 0.8;

    return Scaffold(
      backgroundColor: const Color(0xFF194D54),
      body: Stack(
        children: [
          Scrollbar(
            thumbVisibility: true,
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
                  backgroundColor: Colors.cyan,
                  actions: [
                    isLandscape
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => _launchURL('/resume.pdf',
                                    webOnlyWindowName: '_self'),
                                child: const Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.doc,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Resume',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Tooltip(
                              message: 'Resume',
                              child: IconButton(
                                icon: const Icon(
                                  CupertinoIcons.doc,
                                  color: Colors.white,
                                ),
                                onPressed: () => _launchURL('/resume.pdf',
                                    webOnlyWindowName: '_self'),
                              ),
                            ),
                          ),
                  ],
                  leading: isLandscape
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10, bottom: 10, right: 0),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => _logoAnimationController.forward(),
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
                        // Frameworks I currently work on
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: width * 0.3 - 5,
                              decoration: const BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Frameworks',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      isLandscape ? width * 0.03 : width * 0.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppConstants.frameworks,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isLandscape ? width * 0.02 : width * 0.04,
                          ),
                        ),
                        // Tools I use
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Tools',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      isLandscape ? width * 0.03 : width * 0.05,
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: width * 0.3 - 5,
                              decoration: const BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          AppConstants.tools,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isLandscape ? width * 0.02 : width * 0.04,
                          ),
                        ),
                        // My recent projects
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: width * 0.3 - 5,
                              decoration: const BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Projects',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      isLandscape ? width * 0.03 : width * 0.05,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Projects(),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Others',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      isLandscape ? width * 0.03 : width * 0.05,
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                              width: width * 0.3 - 5,
                              decoration: const BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // talks and experiments
                        const OtherLinks(),
                        const SizedBox(height: 20),
                        // non-technical skills
                        const RNNYoutube(),
                        const SizedBox(height: 100),
                        Text(
                          'Reach out to me at',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                isLandscape ? width * 0.015 : width * 0.035,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const SocialIconsAbout(),
                        const SizedBox(height: 25),
                        Text(
                          'Built with Flutter',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: isLandscape ? width * 0.01 : width * 0.03,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text.rich(
                          TextSpan(
                            children: const [
                              TextSpan(text: 'Made with '),
                              TextSpan(
                                text: '💙',
                                style:
                                    TextStyle(fontFamily: 'Noto Color Emoji'),
                              ),
                              TextSpan(text: ' by Sai Rajendra Immadi'),
                            ],
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  isLandscape ? width * 0.02 : width * 0.04,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: isLandscape ? height * 0.13 : height * 0.09,
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
            height: isLandscape ? height * 0.13 : height * 0.09,
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
    );
  }
}

void _launchURL(String url, {String? webOnlyWindowName}) async {
  if (!await launchUrl(Uri.parse(url), webOnlyWindowName: webOnlyWindowName)) {
    throw 'Could not launch $url';
  }
}
