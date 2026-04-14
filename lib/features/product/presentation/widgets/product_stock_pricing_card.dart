import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';

class ProductStockPricingCard extends StatefulWidget {
  final TProductType productType;
  final TextEditingController stockController;
  final TextEditingController priceController;
  final TextEditingController salePriceController;
  final TextEditingController attrNameController;
  final TextEditingController attrValuesController;
  final List<ProductAttributeModel> attributes;
  final void Function(TProductType) onProductTypeChanged;
  final VoidCallback onAddAttribute;
  final void Function(int) onRemoveAttribute;

  const ProductStockPricingCard({
    super.key,
    required this.productType,
    required this.stockController,
    required this.priceController,
    required this.salePriceController,
    required this.attrNameController,
    required this.attrValuesController,
    required this.attributes,
    required this.onProductTypeChanged,
    required this.onAddAttribute,
    required this.onRemoveAttribute,
  });

  @override
  State<ProductStockPricingCard> createState() =>
      _ProductStockPricingCardState();
}

class _ProductStockPricingCardState extends State<ProductStockPricingCard> {
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Stock & Pricing',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Product Type Toggle
          Row(
            children: [
              Text('Product Type  ',
                  style: Theme.of(context).textTheme.bodyMedium),
              _buildRadio('Single', TProductType.single),
              const SizedBox(width: TSizes.sm),
              _buildRadio('Variable', TProductType.variable),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Single-product fields
          if (widget.productType == TProductType.single) ...[
            TextFormField(
              controller: widget.stockController,
              decoration: const InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.priceController,
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: TextFormField(
                    controller: widget.salePriceController,
                    decoration:
                        const InputDecoration(labelText: 'Discounted Price'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
          ],

          // Add attributes
          Text('Add Product Attributes',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: widget.attrNameController,
                  decoration:
                      const InputDecoration(labelText: 'Attribute Name'),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: widget.attrValuesController,
                  decoration: const InputDecoration(
                      labelText: 'Attributes',
                      hintText: 'Comma separated values'),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              ElevatedButton.icon(
                onPressed: () {
                  widget.onAddAttribute();
                },
                icon: const Icon(Iconsax.add, size: 18),
                label: const Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.md, vertical: TSizes.md),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusMd)),
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          // All Attributes List
          Text('All Attributes',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: TSizes.spaceBtwItems),

          if (widget.attributes.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(TSizes.lg),
              decoration: BoxDecoration(
                color: TColors.primaryBackground,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
              ),
              child: Column(
                children: [
                  Icon(Iconsax.color_swatch,
                      size: 60, color: TColors.darkGrey.withOpacity(0.5)),
                  const SizedBox(height: TSizes.sm),
                  const Text('There are no attributes added for this product',
                      style: TextStyle(color: TColors.darkGrey)),
                ],
              ),
            )
          else
            ...widget.attributes.asMap().entries.map(
                  (entry) => Container(
                    margin: const EdgeInsets.only(bottom: TSizes.sm),
                    padding: const EdgeInsets.all(TSizes.md),
                    decoration: BoxDecoration(
                      color: TColors.primaryBackground,
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusMd),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(entry.value.name,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              Text('(${entry.value.values.join(', ')})',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => widget.onRemoveAttribute(entry.key),
                          icon: const Icon(Iconsax.trash, color: TColors.error),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildRadio(String label, TProductType type) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<TProductType>(
          value: type,
          groupValue: widget.productType,
          activeColor: TColors.primary,
          onChanged: (v) {
            if (v != null) widget.onProductTypeChanged(v);
          },
        ),
        Text(label),
      ],
    );
  }
}
