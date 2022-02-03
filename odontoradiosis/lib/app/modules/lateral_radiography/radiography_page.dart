import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:odontoradiosis/app/shared/test_image.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';
import 'package:odontoradiosis_painters/odontoradiosis_painters.dart';

import 'widgets/sidebar/sidebar_widget.dart';
import 'widgets/toolbar/edition_mode_widget.dart';
import 'widgets/toolbar/toolbar_widget.dart';

class LateralRadiographyPage extends StatefulWidget {
  const LateralRadiographyPage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<LateralRadiographyPage> createState() => _LateralRadiographyPageState();
}

class _LateralRadiographyPageState extends State<LateralRadiographyPage> {
  @override
  void initState() {
    Modular.get<LateralCephalometricService>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const [
          EditionModeButtonWidget(),
          ToolbarWidget(),
        ],
      ),
      drawer: Drawer(
        child: SidebarWidget(
          cephalometricService: Modular.get<LateralCephalometricService>(),
        ),
      ),
      body: Center(
        child: CephalometricCanvas(
          tracingDrawInfo: TracingDrawInfo(
            DefaultBezierCurve.create().values.toList(),
            curvePoints: DefaultBezierCurve.create().values.toList().first,
          ),
          landmarkDrawInfo: LandmarkDrawInfo(
            landmarks: [
              SpecificLandmarkInfo(
                ILandmark.create(x: 50, y: 50),
                'Espinha nasal anterior (ENA)',
                const IPointBidimensional(30, 60),
              ),
            ],
          ),
          imageDrawInfo: ImageDrawInfo(
            base64Decode(testImage),
          ),
        ),
      ),
    );
  }
}
