import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_thumbnail_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_images_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_brand_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_categories_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_visibility_card.dart';

class ProductFormSidebar extends StatelessWidget {
  final String? thumbnail;
  final List<String> productImages;
  final String selectedBrand;
  final List<String> selectedCategories;
  final bool isPublished;
  final VoidCallback onPickThumbnail;
  final VoidCallback onPickImages;
  final void Function(String) onRemoveImage;
  final void Function(String?) onBrandChanged;
  final void Function(String?) onCategorySelected;
  final void Function(String) onCategoryRemoved;
  final void Function(bool) onVisibilityChanged;

  const ProductFormSidebar({
    super.key,
    required this.thumbnail,
    required this.productImages,
    required this.selectedBrand,
    required this.selectedCategories,
    required this.isPublished,
    required this.onPickThumbnail,
    required this.onPickImages,
    required this.onRemoveImage,
    required this.onBrandChanged,
    required this.onCategorySelected,
    required this.onCategoryRemoved,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductThumbnailCard(
            thumbnail: thumbnail, onPickThumbnail: onPickThumbnail),
        const SizedBox(height: TSizes.spaceBtwSections),
        ProductImagesCard(
          productImages: productImages,
          onPickImages: onPickImages,
          onRemoveImage: onRemoveImage,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        ProductBrandCard(
            selectedBrand: selectedBrand, onBrandChanged: onBrandChanged),
        const SizedBox(height: TSizes.spaceBtwSections),
        ProductCategoriesCard(
          selectedCategories: selectedCategories,
          onCategorySelected: onCategorySelected,
          onCategoryRemoved: onCategoryRemoved,
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        ProductVisibilityCard(
            isPublished: isPublished, onVisibilityChanged: onVisibilityChanged),
      ],
    );
  }
}
