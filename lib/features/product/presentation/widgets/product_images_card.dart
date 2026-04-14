import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';

class ProductImagesCard extends StatelessWidget {
  final List<String> productImages;
  final VoidCallback onPickImages;
  final void Function(String) onRemoveImage;

  const ProductImagesCard({
    super.key,
    required this.productImages,
    required this.onPickImages,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('All Product Images',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),
          if (productImages.isEmpty)
            GestureDetector(
              onTap: onPickImages,
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: TColors.primaryBackground,
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.image, size: 40, color: TColors.darkGrey),
                    SizedBox(height: TSizes.xs),
                    Text('Add Additional Product Images',
                        style:
                            TextStyle(color: TColors.darkGrey, fontSize: 12)),
                  ],
                ),
              ),
            )
          else
            Wrap(
              spacing: TSizes.sm,
              runSpacing: TSizes.sm,
              children: [
                ...productImages.map(
                  (img) => Stack(
                    children: [
                      TRoundedImage(
                        image: img,
                        width: 60,
                        height: 60,
                        padding: TSizes.xs,
                        imageType: img.startsWith('http')
                            ? ImageType.network
                            : ImageType.asset,
                        borderRadius: TSizes.sm,
                        backgroundColor: TColors.primaryBackground,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => onRemoveImage(img),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                color: TColors.error, shape: BoxShape.circle),
                            child: const Icon(Icons.close,
                                size: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onPickImages,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: TColors.primaryBackground,
                      borderRadius:
                          BorderRadius.circular(TSizes.borderRadiusSm),
                      border: Border.all(
                          color: TColors.grey.withValues(alpha: 0.3)),
                    ),
                    child: const Icon(Iconsax.add, color: TColors.darkGrey),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
