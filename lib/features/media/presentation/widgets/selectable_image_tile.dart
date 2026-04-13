import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/shimmers/shimmer.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';

/// Image tile with a checkbox overlay for selection in the media picker.
class SelectableImageTile extends StatelessWidget {
  const SelectableImageTile({
    super.key,
    required this.image,
    required this.isSelected,
    required this.onToggle,
  });

  final MediaImageModel image;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // ── Image Container ──────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: TColors.lightGrey,
                    borderRadius:
                        BorderRadius.circular(TSizes.borderRadiusMd),
                    border: Border.all(
                      color: isSelected
                          ? TColors.primary
                          : TColors.borderPrimary,
                      width: isSelected ? 2 : 0.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(TSizes.borderRadiusMd),
                    child: CachedNetworkImage(
                      imageUrl: image.url,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (_, __) => const TShimmerEffect(
                          width: double.infinity,
                          height: double.infinity),
                      errorWidget: (_, __, ___) => const Icon(
                          Iconsax.image,
                          color: TColors.darkGrey),
                    ),
                  ),
                ),

                // ── Checkbox ─────────────────────────────
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? TColors.primary
                          : Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected
                            ? TColors.primary
                            : TColors.borderPrimary,
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check,
                            size: 14, color: Colors.white)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: TSizes.xs),
          Text(
            image.name,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
