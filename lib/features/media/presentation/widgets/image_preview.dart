import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/shimmers/shimmer.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.image,
  });

  final MediaImageModel image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: TColors.lightGrey,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        child: CachedNetworkImage(
          imageUrl: image.url,
          fit: BoxFit.contain,
          placeholder: (_, __) => const TShimmerEffect(width: double.infinity, height: double.infinity),
          errorWidget: (_, __, ___) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.image, size: 48, color: TColors.darkGrey),
              SizedBox(height: TSizes.sm),
              Text('Failed to load image'),
            ],
          ),
        ),
      ),
    );
  }
}
