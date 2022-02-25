import 'package:flutter/material.dart';
import 'package:website/router/site_route_path.dart';
import 'package:website/router/site_transition_delegate.dart';
import 'package:website/screens/about/about.dart';
import 'package:website/screens/home/home.dart';
import 'package:website/screens/splash_screen/splash_screen.dart';
import 'package:website/screens/unknown/unknown.dart';

class SiteRouterDelegate extends RouterDelegate<SiteRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<SiteRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  SiteRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  final SiteTransitionDelegate _siteTransitionDelegate =
      SiteTransitionDelegate();

  bool _show404 = false;
  bool _isHome = false;
  bool _isAbout = false;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      transitionDelegate: _siteTransitionDelegate,
      pages: [
        MaterialPage(
          key: const ValueKey('Base'),
          child: Container(),
        ),
        if (_show404)
          const MaterialPage(
              key: ValueKey('UnknownPage'), child: UnknownScreen()),
        if (!_isHome && !_isAbout && !_show404)
          MaterialPage(
            key: const ValueKey('SplashPage'),
            child: SplashScreen(
              onHomeNav: () {
                if (!_show404 && !_isHome && !_isAbout) {
                  _isHome = true;
                  _isAbout = false;
                  notifyListeners();
                }
              },
            ),
          ),
        if (_isHome || _isAbout)
          MaterialPage(
            key: const ValueKey('HomePage'),
            child: Home(
              onAboutPress: () {
                _isHome = false;
                _isAbout = true;
                notifyListeners();
              },
            ),
          ),
        if (_isAbout)
          const MaterialPage(key: ValueKey('AboutPage'), child: About()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _isHome = true;
        _isAbout = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  SiteRoutePath get currentConfiguration {
    if (_show404) {
      return SiteRoutePath.unknown();
    }

    if (_isHome) {
      return SiteRoutePath.home();
    }
    if (_isAbout) {
      return SiteRoutePath.about();
    }
    return SiteRoutePath.splash();
  }

  @override
  Future<void> setNewRoutePath(SiteRoutePath configuration) async {
    if (configuration.isUnknown) {
      _isHome = false;
      _isAbout = false;
      _show404 = true;
      return;
    }

    if (configuration.isAboutPage) {
      _isHome = false;
      _isAbout = true;
    } else if (configuration.isHomePage) {
      _isHome = true;
      _isAbout = false;
    } else if (configuration.isSplashPage) {
      _isHome = false;
      _isAbout = false;
    }

    _show404 = false;
  }
}
