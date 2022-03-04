import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class Name extends StatefulWidget {
  const Name({Key? key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  /// boolean value for logo rotation animation
  /// - _logoHover?.value = true; to rotate
  /// - _logoHover?.value = false; to stop rotating
  SMIBool? _logoHover;

  /// variable which is false first and set to true after widget builds
  ///
  /// this is to ensure the font is loaded before the text is shown
  ///
  /// used with Animated widgets
  var _started = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _started = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return AnimatedOpacity(
      opacity: _started ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              onEnter: (event) => _logoHover?.value = true,
              onExit: (event) => _logoHover?.value = false,
              child: CircleAvatar(
                radius: width * 0.07,
                backgroundColor: const Color(0xFF42C9DB),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RiveAnimation.asset(
                    'assets/rive/s-logo-rotation.riv',
                    fit: BoxFit.cover,
                    onInit: _onLogoRotationInit,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ai Rajendra Immadi',
                style: GoogleFonts.rubik(
                  color: const Color(0xFF42C9DB),
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.075,
                ),
              ),
            ),
          ],
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
}
