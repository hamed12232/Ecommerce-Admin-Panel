import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/shimmers/shimmer.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/auth_service.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controller/user_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controller/user_state.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';

/// Header widget for the application
class THeader extends StatelessWidget implements PreferredSizeWidget {
  const THeader({super.key, this.scaffoldKey});

  /// GlobalKey to access the Scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: TColors.white,
        border: Border(bottom: BorderSide(color: TColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(
        automaticallyImplyLeading: false,

        /// Mobile Menu
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
            : null,

        /// Search Field
        title: TDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.search_normal),
                    hintText: 'Search anything...',
                  ),
                ),
              )
            : null,

        /// Actions
        actions: [
          // Search Icon on Mobile
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(
                icon: const Icon(Iconsax.search_normal),
                onPressed: () async {
                  try {
                    await AuthService.instance.signOut();
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error signing out: $e')),
                      );
                    }
                  }
                }),
          IconButton(icon: const Icon(Iconsax.notification), onPressed: () {}),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state.status == UserStatus.loading ||
                  state.status == UserStatus.initial) {
                return const TShimmerEffect(width: 150, height: 40);
              }
              final user = state.user;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TRoundedImage(
                    width: 40,
                    padding: 2,
                    height: 40,
                    imageType: user?.profilePicture.isNotEmpty == true
                        ? ImageType.network
                        : ImageType.asset,
                    image: user?.profilePicture.isNotEmpty == true
                        ? user!.profilePicture
                        : TImages.user,
                  ),
                  const SizedBox(width: TSizes.sm),

                  // Name and Email
                  if (!TDeviceUtils.isMobileScreen(context))
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user?.userName ?? 'Admin',
                            style: Theme.of(context).textTheme.titleLarge),
                        Text(user?.email ?? 'admin@example.com',
                            style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}
