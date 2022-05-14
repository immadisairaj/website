import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconsAbout extends StatelessWidget {
  const SocialIconsAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SocialIconCard(
          icon: FontAwesomeIcons.github,
          link: 'https://github.com/immadisairaj',
        ),
        SocialIconCard(
          icon: FontAwesomeIcons.twitter,
          link: 'https://twitter.com/immadisairaj',
        ),
        SocialIconCard(
          icon: FontAwesomeIcons.linkedin,
          link: 'http://linkedin.com/in/immadisairaj/',
        ),
        SocialIconCard(
          icon: FontAwesomeIcons.instagram,
          link: 'https://www.instagram.com/immadisairaj/',
        ),
        SocialIconCard(
          icon: Icons.mail_outline,
          link: 'mailto:immadirajendra.sai@gmail.com',
        ),
      ],
    );
  }
}

class SocialIconCard extends StatefulWidget {
  const SocialIconCard({
    Key? key,
    required this.icon,
    required this.link,
  }) : super(key: key);

  final IconData icon;
  final String link;

  @override
  State<SocialIconCard> createState() => _SocialIconCardState();
}

class _SocialIconCardState extends State<SocialIconCard>
    with TickerProviderStateMixin {
  /// controller that drives logo scale animation when in landscape
  late AnimationController _logoAnimationController;
  late Animation<double> _logoScale;

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isLandscape = height < width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) => _logoAnimationController.forward(),
        onExit: (_) => _logoAnimationController.reverse(),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _launchURL(widget.link),
          child: ScaleTransition(
            scale: _logoScale,
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: isLandscape ? width * 0.03 : width * 0.05,
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
