import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: 'Sai Rajendra Immadi',
      theme: _buildTheme(),
      routeInformationParser: siteRouteInformationParser,
      routerDelegate: siteRouterDelegate,
    );
  }

  ThemeData _buildTheme() {
    var baseTheme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.cyan,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.rubikTextTheme(baseTheme.textTheme),
    );
  }
}
