import 'package:flutter/material.dart';
import 'package:website/router/site_route_path.dart';

class SiteRouteInformationParser extends RouteInformationParser<SiteRoutePath> {
  @override
  Future<SiteRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
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
      return RouteInformation(
        uri: Uri.parse('/404'),
      );
    } else if (configuration.isHomePage) {
      return RouteInformation(
        uri: Uri.parse('/home'),
      );
    } else if (configuration.isAboutPage) {
      return RouteInformation(
        uri: Uri.parse('/about'),
      );
    } else if (configuration.isSplashPage) {
      return RouteInformation(
        uri: Uri.parse('/'),
      );
    }
    return null;
  }
}
