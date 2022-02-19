class SiteRoutePath {
  final bool isHome;
  final bool isAbout;
  final bool isUnknown;

  SiteRoutePath.splash()
      : isHome = false,
        isAbout = false,
        isUnknown = false;

  SiteRoutePath.home()
      : isHome = true,
        isAbout = false,
        isUnknown = false;

  SiteRoutePath.about()
      : isHome = false,
        isAbout = true,
        isUnknown = false;

  SiteRoutePath.unknown()
      : isHome = false,
        isAbout = false,
        isUnknown = true;

  bool get isHomePage => isHome && !isAbout && !isUnknown;

  bool get isAboutPage => isAbout && !isHome && !isUnknown;

  bool get isSplashPage => !isHome && !isAbout && !isUnknown;
}
