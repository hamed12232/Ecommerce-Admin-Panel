import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'sidebar_controller.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final menuController = SidebarController.instance;

    return InkWell(
      onTap: () {
        menuController.changeActiveItem(route);
        Navigator.pushNamed(context, route);
      },
      onHover: (hovering) => hovering
          ? menuController.changeHoverItem(route)
          : menuController.changeHoverItem(''),
      child: AnimatedBuilder(
        animation: menuController,
        builder: (context, child) {
          final isActive = menuController.isActive(route);
          final isHovering = menuController.isHovering(route);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
            child: Container(
              decoration: BoxDecoration(
                color: isActive || isHovering
                    ? TColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Padding(
                    padding: const EdgeInsets.only(
                      left: TSizes.lg,
                      top: TSizes.md,
                      bottom: TSizes.md,
                      right: TSizes.md,
                    ),
                    child: isActive
                        ? Icon(icon, color: TColors.white)
                        : Icon(
                            icon,
                            size: 22,
                            color:
                                isHovering ? TColors.white : TColors.darkGrey,
                          ),
                  ),

                  // Text

                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: isActive || isHovering
                              ? TColors.white
                              : TColors.darkGrey),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
