import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website/classes/project_class.dart';

class ProjectWidget extends StatefulWidget {
  final Project project;

  const ProjectWidget({
    super.key,
    required this.project,
  });

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
    if (widget.project.imagePath != null) {
      precacheImage(AssetImage(widget.project.imagePath!), context);
    }
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
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      if (widget.project.subTitle != null)
                        Text(
                          widget.project.subTitle!,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      if (widget.project.subTitle != null)
                        const SizedBox(
                          height: 8,
                        ),
                      if (widget.project.imagePath != null)
                        Image(
                          image: AssetImage(widget.project.imagePath!),
                        ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.project.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
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
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
