import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
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
            const Center(
                child: Padding(
              padding: EdgeInsets.all(TSizes.lg),
              child: Text('Add attributes above to generate variations.',
                  style: TextStyle(color: Colors.grey)),
            ))
          else
            ...variations.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final v = entry.value;
                return ExpansionTile(
                  title: Text(v.attributeSummary),
                  tilePadding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
                      child: Row(
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
                              initialValue: v.stock > 0 ? v.stock.toString() : '',
                              decoration:
                                  const InputDecoration(labelText: 'Stock'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: TextFormField(
                              initialValue: v.price > 0 ? v.price.toString() : '',
                              decoration:
                                  const InputDecoration(labelText: 'Price'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Expanded(
                            child: TextFormField(
                              initialValue:
                                  v.salePrice > 0 ? v.salePrice.toString() : '',
                              decoration:
                                  const InputDecoration(labelText: 'Sale Price'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.sm),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
