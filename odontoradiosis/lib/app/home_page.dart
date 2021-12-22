import 'package:flutter/material.dart';
import 'package:odontoradiosis_painters/odontoradiosis_painters.dart';

import 'widgets/sidebar/sidebar_widget.dart';
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
          ToolbarWidget(),
        ],
      ),
      drawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SidebarWidget(),
        ),
      ),
      body: const Center(
        child: CephalometricCanvas(),
      ),
    );
  }
}
