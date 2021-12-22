import 'package:flutter/material.dart';
import 'package:odontoradiosis/app/widgets/sidebar/sidebar_controller.dart';
import 'package:odontoradiosis/app/widgets/utils/reactive_dropdown_button.dart';
import 'package:odontoradiosis/core/util/available_effects.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({Key? key}) : super(key: key);

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  final SidebarController _controller;

  _SidebarWidgetState() : _controller = SidebarController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ReactiveDropdownButton<String>(
          items: _controller.supportedCurves,
          decoration: const InputDecoration(label: Text('Anatomical Tracing')),
          onChanged: (value) {
            if (value != null) {
              _controller.curveSelect(value);
            }
          },
        ),
        ReactiveDropdownButton<String>(
          items: _controller.supportedLandmarks,
          decoration: const InputDecoration(label: Text('Landmarks')),
          onChanged: (value) {
            if (value != null) {
              _controller.landmarkSelect(value);
            }
          },
        ),

        // Image effects slider
        Slider(
          value: _controller.grayscaleValue,
          min: 0,
          max: 100,
          label: AvailableEffects.GRAYSCALE.name,
          onChanged: (double value) {
            setState(() {
              _controller.applyEffects('grayscale', value);
            });
          },
        ),
        Slider(
          value: _controller.contrastValue,
          min: 0,
          max: 100,
          label: AvailableEffects.CONTRAST.name,
          onChanged: (double value) {
            setState(() {
              _controller.applyEffects('contrast', value);
            });
          },
        ),
        Slider(
          value: _controller.brightnessValue,
          min: 0,
          max: 100,
          label: AvailableEffects.BRIGHTNESS.name,
          onChanged: (double value) {
            setState(() {
              _controller.applyEffects('brightness', value);
            });
          },
        ),
        Slider(
          value: _controller.negativeValue,
          min: 0,
          max: 100,
          label: AvailableEffects.INVERT.name,
          onChanged: (double value) {
            setState(() {
              _controller.applyEffects('invert', value);
            });
          },
        ),

        // Undone effects button
        ElevatedButton(
          onPressed: _controller.undone,
          child: const Text('Undone'),
        ),
      ],
    );
  }
}
