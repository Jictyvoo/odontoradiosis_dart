import 'package:flutter/material.dart';

import 'home_page.dart';

class OdontoradiosisApp extends StatelessWidget {
  const OdontoradiosisApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Odontoradiosis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RadiographyPage(
        title: 'Odontoradiosis Lateral Cephalometric',
      ),
    );
  }
}
