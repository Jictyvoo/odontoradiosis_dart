import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
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
      body: const Center(
        child: CephalometricCanvas(),
      ),
    );
  }
}
