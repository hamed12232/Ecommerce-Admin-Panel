import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_image_picker.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';

class ProductVariationsCard extends StatelessWidget {
  final List<ProductVariationModel> variations;
  final VoidCallback onRemoveVariations;
  final void Function(int index, String image) onVariationImageChanged;

  const ProductVariationsCard({
    super.key,
    required this.variations,
    required this.onRemoveVariations,
    required this.onVariationImageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Variations',
                  style: Theme.of(context).textTheme.headlineSmall),
              TextButton(
                onPressed: onRemoveVariations,
                child: const Text('Remove Variations',
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          if (variations.isEmpty)
            Center(
                child: Padding(
              padding: const EdgeInsets.all(TSizes.lg),
              child: Column(
                children: [
                  Image.asset(TImages.defaultVariationImageIcon,
                      height: 80, width: 80),
                  const SizedBox(height: TSizes.sm),
                  const Text('There are no Variations added for this product',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ))
          else
            ...variations.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final v = entry.value;
                return TRoundedContainer(
                  backgroundColor: TColors.grey.withValues(alpha: 0.1),
                  margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(v.attributeSummary,  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                final url = await MediaImagePicker.showSingle(
                                    context: context);
                                if (url != null) {
                                  onVariationImageChanged(index, url);
                                }
                              },
                              child: TRoundedContainer(
                                width: 60,
                                height: 60,
                                showBorder: true,
                                backgroundColor: Colors.transparent,
                                child: v.image.isNotEmpty
                                    ? TRoundedImage(
                                        image: v.image,
                                        imageType: v.image.startsWith('http')
                                            ? ImageType.network
                                            : ImageType.asset,
                                        fit: BoxFit.cover,
                                        borderRadius: TSizes.sm,
                                        padding: 0,
                                      )
                                    : const Icon(Iconsax.image),
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),
                            Expanded(
                              child: TextFormField(
                                initialValue:
                                    v.stock > 0 ? v.stock.toString() : '',
                                decoration:
                                    const InputDecoration(labelText: 'Stock'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),
                            Expanded(
                              child: TextFormField(
                                initialValue:
                                    v.price > 0 ? v.price.toString() : '',
                                decoration:
                                    const InputDecoration(labelText: 'Price'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),
                            Expanded(
                              child: TextFormField(
                                initialValue: v.salePrice > 0
                                    ? v.salePrice.toString()
                                    : '',
                                decoration: const InputDecoration(
                                    labelText: 'Sale Price'),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
