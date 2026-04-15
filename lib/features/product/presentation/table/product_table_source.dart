import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';

class ProductRows extends DataTableSource {
  final BuildContext context;
  List<ProductModel> products;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  ProductRows(this.context, this.products);

  /// Sort by a given column index.
  void sort(int columnIndex, bool ascending) {
    _sortColumnIndex = columnIndex;
    _sortAscending = ascending;

    switch (columnIndex) {
      case 0: // Product name
        products.sort((a, b) => ascending
            ? a.title.compareTo(b.title)
            : b.title.compareTo(a.title));
        break;
      case 1: // Stock
        products.sort((a, b) => ascending
            ? a.stock.compareTo(b.stock)
            : b.stock.compareTo(a.stock));
        break;
      case 3: // Price
        products.sort((a, b) => ascending
            ? a.price.compareTo(b.price)
            : b.price.compareTo(a.price));
        break;
    }
    notifyListeners();
  }

  int? get currentSortColumn => _sortColumnIndex;
  bool get isAscending => _sortAscending;

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;
    final product = products[index];

    return DataRow2(
      selected: false,
      onSelectChanged: (_) {},
      cells: [
        // ── Product (Image + Name) ────────────────────
        DataCell(
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.editProduct,
              arguments: product,
            ),
            child: Row(
              children: [
                TRoundedImage(
                  width: 50,
                  height: 50,
                  padding: TSizes.xs,
                  image: product.thumbnail,
                  imageType: product.thumbnail.startsWith('http')
                      ? ImageType.network
                      : ImageType.asset,
                  borderRadius: TSizes.sm,
                  backgroundColor: TColors.primaryBackground,
                ),
                const SizedBox(width: TSizes.sm),
                Expanded(
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: TColors.primary,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Stock ─────────────────────────────────────
        DataCell(Text(product.stock.toString())),

        // ── Brand (icon + name) ───────────────────────
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 30,
                height: 30,
                padding: 2,
                image: product.brandImage,
                imageType: product.brandImage.startsWith('http')
                    ? ImageType.network
                    : ImageType.asset,
                borderRadius: TSizes.sm,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.xs),
              Expanded(
                child: Text(
                  product.brand,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: TColors.primary,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        // ── Price ─────────────────────────────────────
        DataCell(Text(product.priceDisplay)),

        // ── Date ──────────────────────────────────────
        DataCell(Text(product.formattedDate)),

        // ── Action ────────────────────────────────────
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  AppRoutes.editProduct,
                  arguments: product,
                ),
                icon:
                    const Icon(Iconsax.edit, color: TColors.primary, size: 20),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Implement delete
                },
                icon: const Icon(Iconsax.trash, color: TColors.error, size: 20),
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
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
