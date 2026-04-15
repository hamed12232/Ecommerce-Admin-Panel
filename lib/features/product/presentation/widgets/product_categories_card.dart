import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';

class ProductCategoriesCard extends StatelessWidget {
  final List<String> selectedCategories;
  final void Function(String?) onCategorySelected;
  final void Function(String) onCategoryRemoved;

  const ProductCategoriesCard({
    super.key,
    required this.selectedCategories,
    required this.onCategorySelected,
    required this.onCategoryRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final allCats =
        CategoryModel.dummyCategories.map((c) => c.name).toSet().toList();

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),
          DropdownButtonFormField<String>(
            initialValue: null,
            decoration: const InputDecoration(
              hintText: 'Select Categories',
              prefixIcon: Icon(Iconsax.arrow_down),
            ),
            items: allCats
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) {
              if (v != null && !selectedCategories.contains(v)) {
                onCategorySelected(v);
              }
            },
          ),
          if (selectedCategories.isNotEmpty) ...[
            const SizedBox(height: TSizes.sm),
            Wrap(
              spacing: TSizes.xs,
              runSpacing: TSizes.xs,
              children: selectedCategories
                  .map((c) => Chip(
                        label: Text(c, style: const TextStyle(fontSize: 12)),
                        onDeleted: () => onCategoryRemoved(c),
                        backgroundColor: TColors.primaryBackground,
                        side: BorderSide.none,
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
