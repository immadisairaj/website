import 'package:flutter/material.dart';
import 'package:website/router/site_route_information_parser.dart';
import 'package:website/router/site_router_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final SiteRouteInformationParser siteRouteInformationParser =
      SiteRouteInformationParser();
  final SiteRouterDelegate siteRouterDelegate = SiteRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // remove debug checker
      debugShowCheckedModeBanner: false,
      title: 'immadisairaj',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      routeInformationParser: siteRouteInformationParser,
      routerDelegate: siteRouterDelegate,
    );
  }
}
