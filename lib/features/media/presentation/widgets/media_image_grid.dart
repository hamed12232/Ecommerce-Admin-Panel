import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/image_tile.dart';

/// Responsive grid displaying images from the selected Supabase folder.
class MediaImageGrid extends StatelessWidget {
  const MediaImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        if (state.status == MediaStatus.loading && state.images.isEmpty) {
          return Center(
            child: Lottie.asset(
              TImages.defaultLoaderAnimation,
              height: 200,
              width: 200,
            ),
          );
        }

        if (state.status == MediaStatus.error && state.images.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.warning_2,
                    size: 48, color: TColors.darkGrey),
                const SizedBox(height: TSizes.sm),
                Text(state.error ?? 'Something went wrong'),
                const SizedBox(height: TSizes.sm),
                TextButton(
                  onPressed: () => context.read<MediaCubit>().loadImages(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.images.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.image, size: 48, color: TColors.darkGrey),
                const SizedBox(height: TSizes.sm),
                Text(
                  'No images found in ${state.selectedFolder}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: TColors.darkGrey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // ── Image Grid ─────────────────────────────
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                mainAxisSpacing: TSizes.spaceBtwItems,
                crossAxisSpacing: TSizes.spaceBtwItems,
                childAspectRatio: 0.85,
              ),
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                final image = state.images[index];
                return ImageTile(image: image);
              },
            ),

            // ── Load More ──────────────────────────────
            if (state.canLoadMore) ...[
              const SizedBox(height: TSizes.spaceBtwSections),
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
