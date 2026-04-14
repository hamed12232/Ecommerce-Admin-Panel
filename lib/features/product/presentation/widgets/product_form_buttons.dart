import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class ProductFormButtons extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onDiscard;
  final VoidCallback onSave;

  const ProductFormButtons({
    super.key,
    required this.isEditing,
    required this.onDiscard,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: onDiscard,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.lg, vertical: TSizes.md),
            side: const BorderSide(color: TColors.grey),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)),
          ),
          child: const Text('Discard'),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        ElevatedButton(
          onPressed: onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.lg, vertical: TSizes.md),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)),
          ),
          child: Text(isEditing ? 'Save Changes' : 'Save Changes'),
        ),
      ],
    );
  }
}
