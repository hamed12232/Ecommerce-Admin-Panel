import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_basic_info_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_stock_pricing_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_variations_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_thumbnail_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_images_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_brand_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_categories_card.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_visibility_card.dart';

class ProductMobileLayout extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TProductType productType;
  final TextEditingController stockController;
  final TextEditingController priceController;
  final TextEditingController salePriceController;
  final TextEditingController attrNameController;
  final TextEditingController attrValuesController;
  final List<ProductAttributeModel> attributes;
  final List<ProductVariationModel> variations;
  final String? thumbnail;
  final List<String> productImages;
  final String selectedBrand;
  final List<String> selectedCategories;
  final bool isPublished;
  final void Function(TProductType) onProductTypeChanged;
  final VoidCallback onAddAttribute;
  final void Function(int) onRemoveAttribute;
  final VoidCallback onRemoveVariations;
  final VoidCallback onPickThumbnail;
  final VoidCallback onPickImages;
  final void Function(String) onRemoveImage;
  final void Function(String?) onBrandChanged;
  final void Function(String?) onCategorySelected;
  final void Function(String) onCategoryRemoved;
  final void Function(bool) onVisibilityChanged;
  final void Function(int index, String image) onVariationImageChanged;

  const ProductMobileLayout({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.productType,
    required this.stockController,
    required this.priceController,
    required this.salePriceController,
    required this.attrNameController,
    required this.attrValuesController,
    required this.attributes,
    required this.variations,
    required this.thumbnail,
    required this.productImages,
    required this.selectedBrand,
    required this.selectedCategories,
    required this.isPublished,
    required this.onProductTypeChanged,
    required this.onAddAttribute,
    required this.onRemoveAttribute,
    required this.onRemoveVariations,
    required this.onPickThumbnail,
    required this.onPickImages,
    required this.onRemoveImage,
    required this.onBrandChanged,
    required this.onCategorySelected,
    required this.onCategoryRemoved,
    required this.onVisibilityChanged,
    required this.onVariationImageChanged,
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
        ProductBasicInfoCard(
            titleController: titleController,
            descriptionController: descriptionController),
        const SizedBox(height: TSizes.spaceBtwSections),
        ProductStockPricingCard(
          productType: productType,
          stockController: stockController,
          priceController: priceController,
          salePriceController: salePriceController,
          attrNameController: attrNameController,
          attrValuesController: attrValuesController,
          attributes: attributes,
          onProductTypeChanged: onProductTypeChanged,
          onAddAttribute: onAddAttribute,
          onRemoveAttribute: onRemoveAttribute,
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
        const SizedBox(height: TSizes.spaceBtwSections),
        if (productType == TProductType.variable)
          ProductVariationsCard(
              variations: variations, 
              onRemoveVariations: onRemoveVariations,
              onVariationImageChanged: onVariationImageChanged,
          ),
      ],
    );
  }
}
