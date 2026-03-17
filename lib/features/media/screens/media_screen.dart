import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/media/screens/responsive_screens/media_desktop_screen.dart';
import 'package:yt_ecommerce_admin_panel/features/media/screens/responsive_screens/media_mobile_screen.dart';
import 'package:yt_ecommerce_admin_panel/features/media/screens/responsive_screens/media_tablet_screen.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete(
      desktop: MediaDesktopScreen(),
      tablet: MediaTabletScreen(),
      mobile: MediaMobileScreen(),
    );
  }
}
