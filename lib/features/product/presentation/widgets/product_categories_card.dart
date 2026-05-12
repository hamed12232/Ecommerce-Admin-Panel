import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_state.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/presentation/cubit/category_cubit.dart';

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
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),
          BlocBuilder<CategoryCubit, ApiState<List<CategoryModel>>>(
            builder: (context, state) {
              // Loading state
              if (state.isLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: TSizes.md),
                  child: Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              }

              // Error state
              if (state.isError) {
                return Column(
                  children: [
                    Text(
                      'Failed to load categories',
                      style: TextStyle(color: TColors.error),
                    ),
                    const SizedBox(height: TSizes.sm),
                    TextButton.icon(
                      onPressed: () =>
                          context.read<CategoryCubit>().fetchCategories(),
                      icon: const Icon(Iconsax.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                );
              }

              final categories = state.data ?? [];

              if (categories.isEmpty && state.isSuccess) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: TSizes.sm),
                  child: Text(
                    'No categories found.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              final categoryNames =
                  categories.map((c) => c.name).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: null,
                    decoration: const InputDecoration(
                      hintText: 'Select Categories',
                      prefixIcon: Icon(Iconsax.arrow_down),
                    ),
                    items: categoryNames
                        .map(
                            (c) => DropdownMenuItem(value: c, child: Text(c)))
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
                                label:
                                    Text(c, style: const TextStyle(fontSize: 12)),
                                onDeleted: () => onCategoryRemoved(c),
                                backgroundColor: TColors.primaryBackground,
                                side: BorderSide.none,
                              ))
                          .toList(),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
