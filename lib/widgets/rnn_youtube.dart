import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RNNYoutube extends StatefulWidget {
  const RNNYoutube({
    super.key,
  });

  @override
  State<RNNYoutube> createState() => _RNNYoutubeState();
}

class _RNNYoutubeState extends State<RNNYoutube> with TickerProviderStateMixin {
  /// controller that drives project widget card scale animation
  /// when hover
  late AnimationController _cardAnimationController;
  late Animation<double> _cardScale;

  @override
  void didChangeDependencies() {
    // precache image when going to next page (about)
    precacheImage(const AssetImage('assets/rnn.png'), context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _cardAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _cardScale = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(
        parent: _cardAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isLandscape = height < width;
    return SizedBox(
      width: width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _cardAnimationController.forward(),
          onExit: (_) => _cardAnimationController.reverse(),
          child: ScaleTransition(
            scale: _cardScale,
            child: GestureDetector(
              onTap: () {
                _launchURL('https://www.youtube.com/c/RadhaNruthyaNilayam');
              },
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: isLandscape
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text(),
                            _image(),
                          ],
                        )
                      : SizedBox(
                          height: height * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _text(),
                              _image(),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _text() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isLandscape = height < width;
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          'I edit videos at\nRadha Nruthya Nilayam',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isLandscape ? width * 0.03 : height * 0.023,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return const Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Image(
          image: AssetImage('assets/rnn.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topLeft,
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
