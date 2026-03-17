import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/dashboard/screens/responsive_screens/dashboard_responsive_screen.dart';

/// Placeholder dashboard screen — replace with your real dashboard later.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete(
      desktop: DashboardResponsiveScreen(),
    );
  }
}
