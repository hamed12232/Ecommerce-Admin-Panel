import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

/// "Upload Images" elevated button used in the Media screen header.
class UploadImagesButton extends StatelessWidget {
  const UploadImagesButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Iconsax.cloud_add, size: 20),
        label: const Text('Upload Images'),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.md,
            vertical: TSizes.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
          ),
        ),
      ),
    );
  }
}
