import 'package:flutter/material.dart';

class EditionModeButtonWidget extends StatefulWidget {
  const EditionModeButtonWidget({Key? key}) : super(key: key);

  @override
  _EditionModeButtonWidgetState createState() =>
      _EditionModeButtonWidgetState();
}

class _EditionModeButtonWidgetState extends State<EditionModeButtonWidget> {
  bool _isMarkingMode;

  _EditionModeButtonWidgetState() : _isMarkingMode = false;

  void _switchMode(bool value) {
    setState(() {
      _isMarkingMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tooltipTheme = TooltipTheme.of(context);
    return Tooltip(
      decoration: tooltipTheme.decoration,
      textStyle: tooltipTheme.textStyle,
      preferBelow: tooltipTheme.preferBelow,
      showDuration: tooltipTheme.showDuration,
      padding: tooltipTheme.padding,
      message: 'Change between marking/edit modes',
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        onTap: () {
          _switchMode(!_isMarkingMode);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(_isMarkingMode ? Icons.image : Icons.edit),
              Switch(
                value: _isMarkingMode,
                onChanged: _switchMode,
                activeColor: const Color(0xff214284),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
