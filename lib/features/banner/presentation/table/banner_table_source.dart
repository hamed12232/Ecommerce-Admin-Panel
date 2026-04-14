import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/models/banner_model.dart';

class BannerRows extends DataTableSource {
  final BuildContext context;
  final List<BannerModel> banners;

  BannerRows(this.context, this.banners);

  @override
  DataRow? getRow(int index) {
    if (index >= banners.length) return null;
    final banner = banners[index];
    return DataRow2(
      selected: false,
      onSelectChanged: (_) {},
      cells: [
        // ── Banner Image ────────────────────────────────
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
            child: TRoundedImage(
              width: 120,
              height: 60,
              padding: TSizes.xs,
              image: banner.image,
              imageType: banner.image.startsWith('http')
                  ? ImageType.network
                  : ImageType.asset,
              borderRadius: TSizes.sm,
              fit: BoxFit.cover,
              backgroundColor: TColors.primaryBackground,
            ),
          ),
        ),

        // ── Target Screen ──────────────────────────────
        DataCell(
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.editBanner,
              arguments: banner,
            ),
            child: Text(
              banner.targetScreen.isEmpty ? '—' : banner.targetScreen,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: banner.targetScreen.isNotEmpty ? TColors.primary : null),
            ),
          ),
        ),

        // ── Active ────────────────────────────────────
        DataCell(
          Icon(
            banner.isActive ? Iconsax.eye : Iconsax.eye_slash,
            color: banner.isActive ? TColors.primary : TColors.darkGrey,
            size: 24,
          ),
        ),

        // ── Action ───────────────────────────────────
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.editBanner,
                  arguments: banner,
                ),
                icon: const Icon(Iconsax.edit, color: TColors.primary),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Implement delete functionality
                },
                icon: const Icon(Iconsax.trash, color: TColors.error),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => banners.length;

  @override
  int get selectedRowCount => 0;
}
