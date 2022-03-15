import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:website/constants/constants.dart';
import 'package:website/widgets/profile_image.dart';

class Bio extends StatefulWidget {
  const Bio({Key? key, required this.screenHeight, required this.screenWidth})
      : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> with TickerProviderStateMixin {
  late AnimationController _profileImageController;
  late Animation<RelativeRect> _profileImageAnimation;
  final RelativeRect _profileImageOutsidePosition =
      const RelativeRect.fromLTRB(-3000, 0, 3000, 0);
  late RelativeRect _profileImageCurrentPosition;

  late AnimationController _bioTextController;
  late Animation<RelativeRect> _bioTextAnimation;
  final RelativeRect _bioTextOutsidePosition =
      const RelativeRect.fromLTRB(3000, 0, -3000, 0);
  late RelativeRect _bioTextCurrentPosition;

  bool _isVisible = true;

  @override
  void didChangeDependencies() {
    // precache image when going to next page (about)
    precacheImage(const AssetImage('assets/rajendra.jpeg'), context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    profileImageAnimation();
    bioTextAnimation();
  }

  @override
  void dispose() {
    _profileImageController.dispose();
    _bioTextController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Bio oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isVisible) {
      profileImageAnimation(oldWidget: oldWidget);
      bioTextAnimation(oldWidget: oldWidget);
    }
  }

  profileImageAnimation({Bio? oldWidget}) {
    bool isLandscape = widget.screenHeight < widget.screenWidth;
    double firstContentHeight =
        isLandscape ? widget.screenHeight * 0.9 : widget.screenHeight * 0.7;

    RelativeRect initialPosition = _profileImageOutsidePosition;

    if (oldWidget != null &&
        (oldWidget.screenHeight != widget.screenHeight ||
            oldWidget.screenWidth != widget.screenWidth)) {
      initialPosition = _profileImageCurrentPosition;
    } else if (oldWidget != null) {
      return;
    }

    RelativeRect finalPosition = isLandscape
        ? RelativeRect.fromLTRB(widget.screenWidth / 9, widget.screenHeight / 4,
            6 * widget.screenWidth / 9, widget.screenHeight / 4)
        : RelativeRect.fromLTRB(
            widget.screenWidth / 4,
            0.3 * firstContentHeight / 9,
            widget.screenWidth / 4,
            5.5 * firstContentHeight / 9);

    _profileImageController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _profileImageAnimation =
        RelativeRectTween(begin: initialPosition, end: finalPosition)
            .animate(_profileImageController);

    _profileImageCurrentPosition = finalPosition;
    _profileImageController.forward();
  }

  profileImageOutAnimation() {
    RelativeRect initialPosition = _profileImageCurrentPosition;

    RelativeRect finalPosition = _profileImageOutsidePosition;

    _profileImageController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _profileImageAnimation =
        RelativeRectTween(begin: initialPosition, end: finalPosition)
            .animate(_profileImageController);

    _profileImageCurrentPosition = finalPosition;
    _profileImageController.forward();
  }

  bioTextAnimation({Bio? oldWidget}) {
    bool isLandscape = widget.screenHeight < widget.screenWidth;
    double firstContentHeight =
        isLandscape ? widget.screenHeight * 0.9 : widget.screenHeight * 0.7;

    RelativeRect initialPosition = _bioTextOutsidePosition;

    if (oldWidget != null &&
        (oldWidget.screenHeight != widget.screenHeight ||
            oldWidget.screenWidth != widget.screenWidth)) {
      initialPosition = _bioTextCurrentPosition;
    } else if (oldWidget != null) {
      return;
    }

    RelativeRect finalPosition = isLandscape
        ? RelativeRect.fromLTRB(
            3.3 * widget.screenWidth / 9, 0, widget.screenWidth / 9, 0)
        : RelativeRect.fromLTRB(
            10, 3.5 * firstContentHeight / 9, 10, 0.5 * firstContentHeight / 9);

    _bioTextController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _bioTextAnimation =
        RelativeRectTween(begin: initialPosition, end: finalPosition)
            .animate(_bioTextController);

    _bioTextCurrentPosition = finalPosition;
    _bioTextController.forward();
  }

  bioTextOutAnimation() {
    RelativeRect initialPosition = _bioTextCurrentPosition;

    RelativeRect finalPosition = _bioTextOutsidePosition;

    _bioTextController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _bioTextAnimation =
        RelativeRectTween(begin: initialPosition, end: finalPosition)
            .animate(_bioTextController);

    _bioTextCurrentPosition = finalPosition;
    _bioTextController.forward();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = widget.screenHeight < widget.screenWidth;

    double firstContentHeight =
        isLandscape ? widget.screenHeight * 0.9 : widget.screenHeight * 0.7;
    double contentWidth = widget.screenWidth * 0.8;
    return VisibilityDetector(
      key: const Key('bio'),
      onVisibilityChanged: (info) {
        bool newIsVisible = info.visibleFraction > 0.5;
        if (newIsVisible != _isVisible) {
          if (mounted) {
            setState(() {
              _isVisible = newIsVisible;

              if (_isVisible) {
                profileImageAnimation();
                bioTextAnimation();
              } else {
                profileImageOutAnimation();
                bioTextOutAnimation();
              }
            });
          }
        }
      },
      child: SizedBox(
          height: firstContentHeight,
          width: widget.screenWidth,
          child: Stack(
            children: [
              PositionedTransition(
                rect: _profileImageAnimation,
                child: const ProfileImage(),
              ),
              PositionedTransition(
                rect: _bioTextAnimation,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      AppConstants.bio,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        letterSpacing: 2,
                        wordSpacing: 2,
                        height: 1.25,
                        fontSize: isLandscape
                            ? contentWidth / 3 * 0.075
                            : firstContentHeight / 3 * 0.11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
