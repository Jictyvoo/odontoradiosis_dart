import 'package:flutter/material.dart';

class EditionModeButtonWidget extends StatefulWidget {
  const EditionModeButtonWidget({Key? key}) : super(key: key);

  @override
  _EditionModeButtonWidgetState createState() =>
      _EditionModeButtonWidgetState();
}

class _EditionModeButtonWidgetState extends State<EditionModeButtonWidget> {
  bool _changingBackground;

  _EditionModeButtonWidgetState() : _changingBackground = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_changingBackground ? Icons.image : Icons.edit),
        Switch(
          value: _changingBackground,
          onChanged: (bool value) {
            setState(() {
              _changingBackground = value;
            });
          },
          activeColor: const Color(0xff214284),
        ),
      ],
    );
  }
}
