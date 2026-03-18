import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/dashboard/presentation/screens/widgets/dashboard_card.dart';

class TDashboardCards extends StatelessWidget {
  const TDashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = TDeviceUtils.isTabletScreen(context);
    final isDesktop = TDeviceUtils.isDesktopScreen(context);


    // Common list of cards
    final List<Widget> cards = [
      TDashboardCard(
        context: context,
        title: 'Sales total',
        subTitle: '\$45431.54',
        stats: 25,
      ),
      TDashboardCard(
        context: context,
        title: 'Average Order Value',
        subTitle: '\$1009.59',
        stats: -15,
      ),
      TDashboardCard(
        context: context,
        title: 'Total Orders',
        subTitle: '45',
        stats: 44,
      ),
      TDashboardCard(
        context: context,
        title: 'Visitors',
        subTitle: '25,035',
        stats: 2,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: cards.map((card) => Expanded(child: Padding(padding: const EdgeInsets.only(right: TSizes.spaceBtwItems), child: card))).toList(),
      );
    } else if (isTablet) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(child: cards[2]),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(child: cards[3]),
            ],
          ),
        ],
      );
    } else {
      // Mobile
      return Column(
        children: cards.map((card) => Padding(padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems), child: card)).toList(),
      );
    }
  }
}
