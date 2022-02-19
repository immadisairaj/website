import 'package:flutter/material.dart';
import 'package:website/router/site_route_path.dart';
import 'package:website/screens/about/about.dart';
import 'package:website/screens/home/home.dart';
import 'package:website/screens/splash_screen/splash_screen.dart';
import 'package:website/screens/unknown/unknown.dart';

class SiteRouterDelegate extends RouterDelegate<SiteRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<SiteRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  SiteRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  bool show404 = false;
  bool isHome = false;
  bool isAbout = false;
  bool isSplash = true;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: const ValueKey('SplashScreenPage'),
          child: SplashScreen(
            onHomeNav: () {
              if (!show404) {
                isHome = true;
                isAbout = false;
                notifyListeners();
              }
            },
          ),
        ),
        if (show404)
          const MaterialPage(
              key: ValueKey('UnknownPage'), child: UnknownScreen()),
        if (isHome || isAbout)
          MaterialPage(
            key: const ValueKey('HomePage'),
            child: Home(
              onAboutPress: () {
                isHome = false;
                isAbout = true;
                notifyListeners();
              },
            ),
          ),
        if (isAbout)
          const MaterialPage(key: ValueKey('AboutPage'), child: About()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        isHome = true;
        isAbout = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  SiteRoutePath get currentConfiguration {
    if (show404) {
      return SiteRoutePath.unknown();
    }

    if (isHome) {
      return SiteRoutePath.home();
    }
    if (isAbout) {
      return SiteRoutePath.about();
    }
    return SiteRoutePath.splash();
  }

  @override
  Future<void> setNewRoutePath(SiteRoutePath configuration) async {
    if (configuration.isUnknown) {
      isHome = false;
      isAbout = false;
      show404 = true;
      return;
    }

    if (configuration.isAboutPage) {
      isHome = false;
      isAbout = true;
    } else if (configuration.isHomePage) {
      isHome = true;
      isAbout = false;
    } else if (configuration.isSplashPage) {
      isHome = false;
      isAbout = false;
    }

    show404 = false;
  }
}
