import 'package:flutter/material.dart';
import 'package:odontoradiosis_painters/odontoradiosis_painters.dart';

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
      ),
      body: const Center(
        child: CephalometricCanvas(),
      ),
    );
  }
}
