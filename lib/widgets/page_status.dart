import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PageStatus extends StatefulWidget {
  /// Shows where the user is in the scroll view
  ///
  /// tell the [level] from 0 to 100
  /// to update the widget with appropriate visual
  ///
  /// tell if it [isLandscape] else, it will assume
  /// as landscape always
  const PageStatus({super.key, this.level = 0, this.isLandscape = true});

  /// provide the percentage of the current scroll offset of the page
  final double level;

  /// provide if the orientation is landscape or portrait
  final bool isLandscape;

  @override
  State<PageStatus> createState() => _PageStatusState();
}

class _PageStatusState extends State<PageStatus> {
  SMINumber? _level;

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rive/neon-bike.riv',
      artboard: widget.isLandscape ? 'pc' : 'mobile',
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
