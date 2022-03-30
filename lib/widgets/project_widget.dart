import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/classes/project_class.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;

  const ProjectWidget({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget>
    with TickerProviderStateMixin {
  /// controller that drives project widget card scale animation
  /// when hover
  late AnimationController _cardAnimationController;
  late Animation<double> _cardScale;

  @override
  void didChangeDependencies() {
    // precache image when going to next page (about)
    precacheImage(AssetImage(widget.project.imagePath), context);
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
    return StaggeredGridTile.fit(
      crossAxisCellCount: 1,
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
                if (widget.project.link != '') {
                  _launchURL(widget.project.link);
                }
              },
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.project.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.rubik(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.project.subTitle,
                        style: GoogleFonts.rubik(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Image(
                        image: AssetImage(widget.project.imagePath),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.project.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rubik(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
