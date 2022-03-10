import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:website/constants/constants.dart';
import 'package:website/widgets/profile_image.dart';

class Bio extends StatefulWidget {
  const Bio(
      {Key? key,
      required this.controller,
      required this.screenHeight,
      required this.screenWidth})
      : super(key: key);

  final ScrollController controller;

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
  void didUpdateWidget(Bio oldWidget) {
    super.didUpdateWidget(oldWidget);
    profileImageAnimation(oldWidget: oldWidget);
    bioTextAnimation(oldWidget: oldWidget);
  }

  profileImageAnimation({Widget? oldWidget}) {
    bool isLandscape = widget.screenHeight < widget.screenWidth;
    double firstContentHeight =
        isLandscape ? widget.screenHeight * 0.9 : widget.screenHeight * 0.7;

    RelativeRect initialPosition = _profileImageOutsidePosition;

    if (oldWidget != null) {
      initialPosition = _profileImageCurrentPosition;
    }

    RelativeRect finalPosition = isLandscape
        ? RelativeRect.fromLTRB(widget.screenWidth / 9, widget.screenHeight / 4,
            6 * widget.screenWidth / 9, widget.screenHeight / 4)
        : RelativeRect.fromLTRB(
            widget.screenWidth / 4,
            0.3 * firstContentHeight / 9,
            widget.screenWidth / 4,
            5.5 * firstContentHeight / 9);

    _profileImageController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _profileImageAnimation =
        RelativeRectTween(begin: initialPosition, end: finalPosition)
            .animate(_profileImageController);

    _profileImageCurrentPosition = finalPosition;
    _profileImageController.forward();
  }

  bioTextAnimation({Widget? oldWidget}) {
    bool isLandscape = widget.screenHeight < widget.screenWidth;
    double firstContentHeight =
        isLandscape ? widget.screenHeight * 0.9 : widget.screenHeight * 0.7;

    RelativeRect initialPosition = _bioTextOutsidePosition;

    if (oldWidget != null) {
      initialPosition = _bioTextCurrentPosition;
    }

    RelativeRect finalPosition = isLandscape
        ? RelativeRect.fromLTRB(
            3.3 * widget.screenWidth / 9, 0, widget.screenWidth / 9, 0)
        : RelativeRect.fromLTRB(
            10, 3.5 * firstContentHeight / 9, 10, 0.5 * firstContentHeight / 9);

    _bioTextController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
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
    return SizedBox(
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
        ));
  }
}

// @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     bool isLandscape = height < width;

//     double firstContentHeight = isLandscape ? height * 0.9 : height * 0.7;
//     double contentWidth = width * 0.8;
//     return SizedBox(
//       height: firstContentHeight,
//       width: contentWidth,
//       child: isLandscape
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: PositionedTransition(
//                       rect: rectAnimation,
//                       child: const ProfileImage(),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 5,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Text(
//                       AppConstants.bio,
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.rubik(
//                         color: Colors.white,
//                         letterSpacing: 2,
//                         wordSpacing: 2,
//                         height: 1.25,
//                         fontSize: contentWidth / 3 * 0.075,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 const Expanded(
//                   flex: 2,
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0),
//                     child: ProfileImage(),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                     child: Text(
//                       AppConstants.bio,
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.rubik(
//                         color: Colors.white,
//                         letterSpacing: 0.2,
//                         fontSize: firstContentHeight / 3 * 0.11,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
