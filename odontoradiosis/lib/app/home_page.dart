import 'package:flutter/material.dart';
import 'package:odontoradiosis/core/infra/repositories/image_repository_impl.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_painters/odontoradiosis_painters.dart';

import 'widgets/sidebar/sidebar_widget.dart';
import 'widgets/toolbar/edition_mode_widget.dart';
import 'widgets/toolbar/toolbar_widget.dart';

class RadiographyPage extends StatefulWidget {
  const RadiographyPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RadiographyPage> createState() => _RadiographyPageState();
}

class _RadiographyPageState extends State<RadiographyPage> {
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
          cephalometricService: CephalometricCanvasService(
            ImageRepositoryImpl(),
          ),
        ),
      ),
      body: const Center(
        child: CephalometricCanvas(),
      ),
    );
  }
}
