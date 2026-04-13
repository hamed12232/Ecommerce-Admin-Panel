import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';

class CategoryRows extends DataTableSource {
  final BuildContext context;
  final List<CategoryModel> categories;

  CategoryRows(this.context, this.categories);

  @override
  DataRow? getRow(int index) {
    if (index >= categories.length) return null;
    final category = categories[index];
    return DataRow2(
      selected: false,
      onSelectChanged: (_) {},
      cells: [
        // ── Category Image + Name ────────────────────
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 45,
                height: 45,
                padding: TSizes.xs,
                image: category.image,
                imageType: ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.editCategory,
                    arguments: category,
                  ),
                  child: Text(
                    category.name,
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

        // ── Parent Category ──────────────────────────
        DataCell(Text(
          category.parentCategory.isEmpty ? '—' : category.parentCategory,
        )),

        // ── Featured ─────────────────────────────────
        DataCell(
          Icon(
            category.isFeatured ? Iconsax.heart5 : Iconsax.heart,
            color: category.isFeatured ? TColors.primary : TColors.darkGrey,
          ),
        ),

        // ── Date ─────────────────────────────────────
        DataCell(Text(category.formattedDate)),

        // ── Action ───────────────────────────────────
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.editCategory,
                  arguments: category,
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
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}
