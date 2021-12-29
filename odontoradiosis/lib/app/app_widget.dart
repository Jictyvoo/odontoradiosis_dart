import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/app_routes.dart';

class OdontoradiosisApp extends StatelessWidget {
  const OdontoradiosisApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Odontoradiosis',
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
      darkTheme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: AppRoutes.DEFAULT.route,
    ).modular();
  }
}
