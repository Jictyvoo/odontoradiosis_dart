import 'package:flutter/material.dart';

class OdontoradiosisFooter extends StatelessWidget {
  final Color? backgroundColor;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Widget? child;
  static const _enterpriseBirthDate = 2021;

  const OdontoradiosisFooter({
    Key? key,
    this.backgroundColor,
    this.alignment = Alignment.bottomCenter,
    this.padding = const EdgeInsets.all(5.0),
    this.child,
  }) : super(key: key);

  Widget _buildContent() {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        runSpacing: 10,
        spacing: 10,
        children: [
          Text(
            '©$_enterpriseBirthDate - ${DateTime.now().year}',
            strutStyle: const StrutStyle(fontWeight: FontWeight.w300),
          ),
          const Text(
            'Jictyvoo',
            strutStyle: StrutStyle(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: child ?? _buildContent(),
        ),
      ),
    );
  }
}
