import 'package:flutter/material.dart';
import 'package:website/router/site_route_path.dart';

class SiteRouteInformationParser extends RouteInformationParser<SiteRoutePath> {
  @override
  Future<SiteRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    if (uri.pathSegments.isEmpty) {
      return SiteRoutePath.splash();
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0].toLowerCase() == 'home') {
        return SiteRoutePath.home();
      } else if (uri.pathSegments[0].toLowerCase() == 'about') {
        return SiteRoutePath.about();
      }
    }
    return SiteRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(
        location: '/404',
      );
    } else if (configuration.isHomePage) {
      return const RouteInformation(
        location: '/home',
      );
    } else if (configuration.isAboutPage) {
      return const RouteInformation(
        location: '/about',
      );
    } else if (configuration.isSplashPage) {
      return const RouteInformation(
        location: '/',
      );
    }
    return null;
  }
}
