import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';

class ProductBrandCard extends StatelessWidget {
  final String selectedBrand;
  final void Function(String?) onBrandChanged;

  const ProductBrandCard({
    super.key,
    required this.selectedBrand,
    required this.onBrandChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),
          DropdownButtonFormField<String>(
            value: selectedBrand.isEmpty ? null : selectedBrand,
            decoration: const InputDecoration(
              hintText: 'Select Brand',
              prefixIcon: Icon(Iconsax.setting_4),
            ),
            items: BrandModel.dummyBrands
                .map((b) => DropdownMenuItem(
                      value: b.name,
                      child: Text(b.name),
                    ))
                .toList(),
            onChanged: onBrandChanged,
          ),
        ],
      ),
    );
  }
}
