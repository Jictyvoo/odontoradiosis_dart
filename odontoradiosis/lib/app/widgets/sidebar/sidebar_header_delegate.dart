import 'package:flutter/material.dart';

class SidebarHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final brightness = Theme.of(context).brightness;
    final imagePath = brightness == Brightness.light
        ? 'assets/images/odontoradiosis_logo_b.png'
        : 'assets/images/odontoradiosis_logo.png';
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: constraints,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset(
              imagePath,
              width: constraints.minWidth,
              height: constraints.maxHeight,
            ),
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  double get maxExtent => 210.0;

  @override
  double get minExtent => 180.0;
}
