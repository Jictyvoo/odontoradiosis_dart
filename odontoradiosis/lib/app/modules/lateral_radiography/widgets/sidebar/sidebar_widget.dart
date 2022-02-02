import 'package:flutter/material.dart';
import 'package:odontoradiosis/app/widgets/utils/footer.dart';
import 'package:odontoradiosis/core/util/available_effects.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';

import 'sidebar_controller.dart';
import 'sidebar_header_delegate.dart';

class SidebarWidget extends StatefulWidget {
  final LateralCephalometricService _cephalometricService;

  const SidebarWidget({
    Key? key,
    required LateralCephalometricService cephalometricService,
  })  : _cephalometricService = cephalometricService,
        super(key: key);

  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  late final SidebarController _controller;

  _SidebarWidgetState();

  @override
  void initState() {
    super.initState();
    _controller = SidebarController(widget._cephalometricService);
  }

  Widget _buildSlider(final Slider slider, final String name) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffa74abf)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            slider,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSideActions() {
    return [
      DropdownButtonFormField<String>(
        items: [
          for (final element in _controller.supportedCurves)
            DropdownMenuItem<String>(value: element, child: Text(element))
        ],
        value: _controller.selectedCurve,
        isExpanded: true,
        decoration: const InputDecoration(label: Text('Anatomical Tracing')),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _controller.curveSelect(value);
            });
          }
        },
      ),
      DropdownButtonFormField<String>(
        items: [
          for (final element in _controller.supportedLandmarks)
            DropdownMenuItem<String>(value: element, child: Text(element))
        ],
        value: null,
        isExpanded: true,
        decoration: const InputDecoration(label: Text('Landmarks')),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _controller.landmarkSelect(value);
            });
          }
        },
      ),

      const SizedBox(height: 8),
      // Image effects slider
      _buildSlider(
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
        'Grayscale',
      ),
      const SizedBox(height: 8),
      _buildSlider(
        Slider(
          value: _controller.contrastValue,
          min: 0,
          max: 100,
          label: _controller.contrastValue.toString(),
          onChanged: (double value) {
            setState(() {
              _controller.applyEffects('contrast', value);
            });
          },
        ),
        'Contrast',
      ),
      const SizedBox(height: 8),
      _buildSlider(
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
        'Brightness',
      ),
      const SizedBox(height: 8),
      _buildSlider(
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
        'Invert',
      ),
      const SizedBox(height: 8),

      // Undone effects button
      ElevatedButton(
        onPressed: () {
          setState(() {
            _controller.undone();
          });
        },
        child: const Text('Undone'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          delegate: SidebarHeaderDelegate(),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sliver: SliverList(
            delegate: SliverChildListDelegate.fixed(_buildSideActions()),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Expanded(child: SizedBox.shrink(), flex: 3),
              Expanded(child: OdontoradiosisFooter(), flex: 2),
            ],
          ),
        ),
      ],
    );
  }
}
