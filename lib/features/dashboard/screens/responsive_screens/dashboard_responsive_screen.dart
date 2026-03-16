import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/dashboard/screens/widgets/dashboard_cards.dart';
import 'package:yt_ecommerce_admin_panel/features/dashboard/screens/widgets/order_status_pie_chart.dart';
import 'package:yt_ecommerce_admin_panel/features/dashboard/screens/widgets/weekly_sales_graph.dart';

class DashboardResponsiveScreen extends StatelessWidget {
  const DashboardResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: TSizes.spaceBtwSections),
            const TDashboardCards(),
            const SizedBox(height: TSizes.spaceBtwSections),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 2, child: WeeklySalesGraph()),
                if (TDeviceUtils.isDesktopScreen(context))
                  const SizedBox(width: TSizes.spaceBtwSections),
                if (TDeviceUtils.isDesktopScreen(context))
                  const Expanded(
                      child: OrderStatusPieChart()
                  ),
              ],
            ),
            if (!TDeviceUtils.isDesktopScreen(context))
              const SizedBox(height: TSizes.spaceBtwSections),
            if (!TDeviceUtils.isDesktopScreen(context))
              const OrderStatusPieChart(),
          ],
        ),
      ),
    );
  }
}
