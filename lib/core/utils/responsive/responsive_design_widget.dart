import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class ResponsiveDesignWidget extends StatelessWidget {
  const ResponsiveDesignWidget(
      {super.key,
      required this.desktop,
      required this.tablet,
      required this.mobile});
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= TSizes.desktopScreenSize) {
          return desktop;
        } else if (constraints.maxWidth >= TSizes.tabletScreenSize) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
