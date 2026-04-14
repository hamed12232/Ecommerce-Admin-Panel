import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class ProductThumbnailCard extends StatelessWidget {
  final String? thumbnail;
  final VoidCallback onPickThumbnail;

  const ProductThumbnailCard({
    super.key,
    required this.thumbnail,
    required this.onPickThumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        children: [
          Text('Product Thumbnail',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),
          GestureDetector(
            onTap: onPickThumbnail,
            child: Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: TColors.primaryBackground,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                border: Border.all(color: TColors.grey.withValues(alpha: 0.3)),
              ),
              child: thumbnail != null && thumbnail!.isNotEmpty
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusMd),
                      child: TRoundedImage(
                        image: thumbnail,
                        width: double.infinity,
                        height: 180,
                        padding: 0,
                        fit: BoxFit.cover,
                        borderRadius: TSizes.borderRadiusMd,
                        imageType: thumbnail!.startsWith('http')
                            ? ImageType.network
                            : ImageType.asset,
                      ),
                    )
                  : const Center(
                      child: Icon(Iconsax.image,
                          size: 80, color: TColors.darkGrey),
                    ),
            ),
          ),
          const SizedBox(height: TSizes.sm),
          OutlinedButton(
            onPressed: onPickThumbnail,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: TColors.grey),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)),
            ),
            child: const Text('Add Thumbnail'),
          ),
        ],
      ),
    );
  }
}
