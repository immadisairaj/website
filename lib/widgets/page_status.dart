import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PageStatus extends StatefulWidget {
  /// Shows where the user is in the scroll view
  ///
  /// tell the [level] from 0 to 100
  /// to update the widget with appropriate visual
  const PageStatus({Key? key, this.level = 0}) : super(key: key);

  /// provide the percentage of the current scroll offset of the page
  final double level;

  @override
  State<PageStatus> createState() => _PageStatusState();
}

class _PageStatusState extends State<PageStatus> {
  SMINumber? _level;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isLandscape = height < width;

    return RiveAnimation.asset(
      'assets/rive/neon-bike.riv',
      artboard: isLandscape ? 'pc' : 'mobile',
      fit: BoxFit.fitWidth,
      alignment: Alignment.bottomCenter,
      onInit: _onBoxStateInit,
    );
  }

  @override
  void didUpdateWidget(covariant PageStatus oldWidget) {
    // update the position of the widget from the new level given
    _level?.value = widget.level;
    super.didUpdateWidget(oldWidget);
  }

  /// Initialize the rive controller when building widget
  void _onBoxStateInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'status');
    artboard.addController(controller!);

    _level = controller.findInput<double>('level') as SMINumber;
    _level?.value = widget.level;
  }
}
