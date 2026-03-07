import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../images/t_circular_image.dart';
import 'menu_item.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width: 1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              const TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.3),
                    ),

                    // Menu Items
                    const TMenuItem(
                        route: '/',
                        icon: Iconsax.home_1,
                        itemName: 'Dashboard'),
                    const TMenuItem(
                        route: '/products',
                        icon: Iconsax.shopping_bag,
                        itemName: 'Products'),
                    const TMenuItem(
                        route: '/categories',
                        icon: Iconsax.category,
                        itemName: 'Categories'),
                    const TMenuItem(
                        route: '/users', icon: Iconsax.user, itemName: 'Users'),
                    const TMenuItem(
                        route: '/orders',
                        icon: Iconsax.shopping_cart,
                        itemName: 'Orders'),
                    const TMenuItem(
                        route: '/settings',
                        icon: Iconsax.setting_2,
                        itemName: 'Settings'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
