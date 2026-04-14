import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';

class BrandRows extends DataTableSource {
  final BuildContext context;
  final List<BrandModel> brands;

  BrandRows(this.context, this.brands);

  @override
  DataRow? getRow(int index) {
    if (index >= brands.length) return null;
    final brand = brands[index];
    return DataRow2(
      selected: false,
      onSelectChanged: (_) {},
      cells: [
        // ── Brand Image + Name ────────────────────
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 45,
                height: 45,
                padding: TSizes.xs,
                image: brand.image,
                imageType: ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.editBrand,
                    arguments: brand,
                  ),
                  child: Text(
                    brand.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: TColors.primary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Categories ──────────────────────────
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
            child: Text(
              brand.categories.isEmpty ? '—' : brand.categories.join(', '),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        // ── Featured ─────────────────────────────────
        DataCell(
          Icon(
            brand.isFeatured ? Iconsax.heart5 : Iconsax.heart,
            color: brand.isFeatured ? TColors.primary : TColors.darkGrey,
          ),
        ),

        // ── Date ─────────────────────────────────────
        DataCell(Text(brand.formattedDate)),

        // ── Action ───────────────────────────────────
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.editBrand,
                  arguments: brand,
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
  int get rowCount => brands.length;

  @override
  int get selectedRowCount => 0;
}
