import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/desktop_layout.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/mobile_layout.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/responsive_design_widget.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/tablet_layout.dart';

class SiteTemplete extends StatelessWidget {
  const SiteTemplete(
      {super.key,
      this.desktop,
      this.tablet,
      this.mobile,
      this.useLayout = true});
  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveDesignWidget(
        desktop: useLayout
            ? DesktopLayout(
                body: desktop,
              )
            : desktop ?? Container(),
        tablet: useLayout
            ? TabletLayout(
                body: tablet?? desktop,
              )
            : tablet ?? desktop ?? Container(),
        mobile: useLayout
            ? MobileLayout(
                body: mobile?? desktop,
              )
            : mobile ?? desktop ?? Container(),
      ),
    );
  }
}
