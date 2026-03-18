import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';

/// Horizontal scrollable row of image thumbnails with remove buttons.
class UploadThumbnailsRow extends StatelessWidget {
  const UploadThumbnailsRow({super.key, required this.files});

  final List<LocalMediaFile> files;

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: TSizes.spaceBtwItems),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: files.length,
            separatorBuilder: (_, __) => const SizedBox(width: TSizes.sm),
            itemBuilder: (_, index) {
              final file = files[index];
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(TSizes.borderRadiusSm),
                    child: Image.memory(file.bytes,
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () => context
                          .read<MediaCubit>()
                          .removeLocalFile(index),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
