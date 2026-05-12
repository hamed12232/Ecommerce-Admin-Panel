import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_state.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/cubit/brand_cubit.dart';

class ProductBrandCard extends StatelessWidget {
  final String selectedBrand;
  final void Function(BrandModel?) onBrandChanged;

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
          BlocBuilder<BrandCubit, ApiState<List<BrandModel>>>(
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
                      'Failed to load brands',
                      style: TextStyle(color: TColors.error),
                    ),
                    const SizedBox(height: TSizes.sm),
                    TextButton.icon(
                      onPressed: () =>
                          context.read<BrandCubit>().fetchBrands(),
                      icon: const Icon(Iconsax.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                );
              }

              final brands = state.data ?? [];

              if (brands.isEmpty && state.isSuccess) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: TSizes.sm),
                  child: Text(
                    'No brands found.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              // Ensure selectedBrand is valid
              final validValue = brands.any((b) => b.name == selectedBrand)
                  ? selectedBrand
                  : null;

              return DropdownButtonFormField<String>(
                value: validValue,
                decoration: const InputDecoration(
                  hintText: 'Select Brand',
                  prefixIcon: Icon(Iconsax.setting_4),
                ),
                items: brands
                    .map((b) => DropdownMenuItem(
                          value: b.name,
                          child: Text(b.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  BrandModel? selected;
                  for (final brand in brands) {
                    if (brand.name == value) {
                      selected = brand;
                      break;
                    }
                  }
                  onBrandChanged(selected);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
