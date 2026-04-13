import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/selectable_image_tile.dart';

/// Grid that displays images with selectable checkboxes for the media picker.
class SelectableMediaImageGrid extends StatelessWidget {
  const SelectableMediaImageGrid({
    super.key,
    required this.selectedUrls,
    required this.onToggle,
    this.allowMultiple = true,
  });

  final Set<String> selectedUrls;
  final void Function(String url) onToggle;
  final bool allowMultiple;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        // ── Loading ──────────────────────────────────
        if (state.status == MediaStatus.loading && state.images.isEmpty) {
          return Center(
            child: Lottie.asset(
              TImages.defaultLoaderAnimation,
              height: 150,
              width: 150,
            ),
          );
        }

        // ── Error ────────────────────────────────────
        if (state.status == MediaStatus.error && state.images.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.warning_2,
                    size: 40, color: TColors.darkGrey),
                const SizedBox(height: TSizes.sm),
                Text(state.error ?? 'Something went wrong',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: TSizes.sm),
                TextButton(
                  onPressed: () => context.read<MediaCubit>().loadImages(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // ── Empty ────────────────────────────────────
        if (state.images.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.image,
                    size: 40, color: TColors.darkGrey),
                const SizedBox(height: TSizes.sm),
                Text(
                  'No images in ${state.selectedFolder}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: TColors.darkGrey),
                ),
              ],
            ),
          );
        }

        // ── Grid + Load More ─────────────────────────
        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 140,
                mainAxisSpacing: TSizes.spaceBtwItems,
                crossAxisSpacing: TSizes.spaceBtwItems,
                childAspectRatio: 0.85,
              ),
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                final image = state.images[index];
                return SelectableImageTile(
                  image: image,
                  isSelected: selectedUrls.contains(image.url),
                  onToggle: () => onToggle(image.url),
                );
              },
            ),
            if (state.canLoadMore) ...[
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => context.read<MediaCubit>().loadMore(),
                  icon: const Icon(Iconsax.arrow_down, size: 18),
                  label: const Text('Load More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.lg, vertical: TSizes.md),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
