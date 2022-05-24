import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatefulWidget {
  const SocialIcons({Key? key}) : super(key: key);

  @override
  _SocialIconsState createState() => _SocialIconsState();
}

class _SocialIconsState extends State<SocialIcons> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    /// is true when the platform is on mobile
    bool isWebMobile = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);

    return MouseRegion(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // use [SocialBoxAnimation] widget to access animated boxes
          SocialBoxAnimation(
            artBoard: 'github',
            height: height,
            width: width,
            isWebMobile: isWebMobile,
            link: 'https://github.com/immadisairaj',
          ),
          SocialBoxAnimation(
            artBoard: 'twitter',
            height: height,
            width: width,
            isWebMobile: isWebMobile,
            link: 'https://twitter.com/immadisairaj',
          ),
          SocialBoxAnimation(
            artBoard: 'linkedin',
            height: height,
            width: width,
            isWebMobile: isWebMobile,
            link: 'http://linkedin.com/in/immadisairaj/',
          ),
          SocialBoxAnimation(
            artBoard: 'instagram',
            height: height,
            width: width,
            isWebMobile: isWebMobile,
            link: 'https://www.instagram.com/immadisairaj/',
          ),
          SocialBoxAnimation(
            artBoard: 'mail',
            height: height,
            width: width,
            isWebMobile: isWebMobile,
            link: 'mailto:mail+website@immadisairaj.dev',
          ),
        ],
      ),
    );
  }
}

/// Returns the floating boxes with icons and link redirect to it
///
/// [artBoard] - specify the artboard of the social icon
/// (github,twitter,linkedin,instagram,mail)
///
/// [height] and [width] are the sizes of the whole screen
///
/// [isWebMobile] - specify if the browser is on mobile
///
/// [link] - specify the link to redirect to;
/// uses "url_launcher" to launch the links
class SocialBoxAnimation extends StatefulWidget {
  const SocialBoxAnimation({
    Key? key,
    required this.artBoard,
    required this.height,
    required this.width,
    required this.isWebMobile,
    required this.link,
  }) : super(key: key);

  final String artBoard;
  final double height;
  final double width;
  final bool isWebMobile;
  final String link;

  @override
  State<SocialBoxAnimation> createState() => _SocialBoxAnimationState();
}

class _SocialBoxAnimationState extends State<SocialBoxAnimation> {
  /// tells if it's mobile or not
  ///
  /// use _isMobile!.value to know if it's mobile
  ///
  /// automatically initialized from [widget.isWebMobile]
  SMIBool? _isMobile;

  /// change the state of box to flap or not
  /// - _flap?.value = 0 to close
  /// - flap?.value = 1 to flap
  SMINumber? _flap;

  /// trigger to completely open the box
  ///
  /// use _hoverTrigger?.fire()
  SMITrigger? _hoverTrigger;

  /// mandatory change the variable when hover
  /// - _hover?.value = true when hovered
  /// - _hover?.value = false when not hovered
  SMIBool? _hover;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _flap?.value = 1,
      onExit: (_) => _flap?.value = 0,
      child: SizedBox(
        height: widget.height > widget.width
            ? widget.width * 0.2
            : widget.width * 0.1,
        width: widget.height > widget.width
            ? widget.width * 0.2
            : widget.width * 0.1,
        child: Center(
          child: MouseRegion(
            onEnter: (_) {
              _hoverTrigger?.fire();
              _hover?.value = true;
            },
            onExit: (_) {
              _hover?.value = false;
            },
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              height: widget.height > widget.width
                  ? widget.width * 0.15
                  : widget.width * 0.07,
              width: widget.height > widget.width
                  ? widget.width * 0.15
                  : widget.width * 0.07,
              child: GestureDetector(
                onTap: () {
                  if (widget.isWebMobile) {
                    _launchURL(widget.link);
                  } else {
                    _hover?.value = false;
                    _launchURL(widget.link);
                  }
                },
                child: RiveAnimation.asset(
                  'assets/rive/water-home.riv',
                  artboard: widget.artBoard,
                  fit: BoxFit.contain,
                  onInit: _onBoxStateInit,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onBoxStateInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'sm');
    artboard.addController(controller!);

    _isMobile = controller.findInput<bool>('mobile') as SMIBool;
    _isMobile?.value = widget.isWebMobile ? true : false;

    _flap = controller.findInput<double>('flap') as SMINumber;
    _flap?.value = 0;

    _hoverTrigger = controller.findInput<bool>('hover trigger') as SMITrigger;
    _hover = controller.findInput<bool>('hover') as SMIBool;
  }
}

void _launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
