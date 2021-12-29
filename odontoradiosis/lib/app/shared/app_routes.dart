enum AppRoutes {
  DEFAULT,
  LATERAL_RADIOGRAPHY,
  HOME,
}

extension AppRoutesUtil on AppRoutes {
  String get route {
    switch (this) {
      case AppRoutes.DEFAULT:
        return '/';
      case AppRoutes.LATERAL_RADIOGRAPHY:
        return '/lateral-radiography';
      case AppRoutes.HOME:
        return '/home';
    }
  }
}
