import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/cubit/product_cubit.dart';

class ProductRows extends DataTableSource {
  final BuildContext context;
  List<ProductModel> products;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  ProductRows(this.context, this.products);

  String _brandImageFor(ProductModel product) {
    if (product.brandImage.isNotEmpty) {
      return product.brandImage;
    }
    if (product.brandData?.image.isNotEmpty == true) {
      return product.brandData!.image;
    }
    return TImages.defaultImage;
  }

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
            onTap: () async {
              final result = await Navigator.pushNamed(
                context,
                AppRoutes.editProduct,
                arguments: product,
              );
              if (result == true && context.mounted) {
                context.read<ProductCubit>().fetchProducts();
              }
            },
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
                image: _brandImageFor(product),
                imageType: _brandImageFor(product).startsWith('http')
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
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    AppRoutes.editProduct,
                    arguments: product,
                  );
                  if (result == true && context.mounted) {
                    context.read<ProductCubit>().fetchProducts();
                  }
                },
                icon:
                    const Icon(Iconsax.edit, color: TColors.primary, size: 20),
              ),
              IconButton(
                onPressed: () {
                  context.read<ProductCubit>().deleteProduct(product.id);
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
