import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/shimmers/shimmer.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/image_detail_dialog.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({super.key, required this.image});

  final MediaImageModel image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
          value: context.read<MediaCubit>(),
          child: ImageDetailDialog(image: image),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: TColors.lightGrey,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                border: Border.all(color: TColors.borderPrimary, width: 0.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                child: CachedNetworkImage(
                  imageUrl: image.url,
                  fit: BoxFit.contain,
                  placeholder: (_, __) => const TShimmerEffect(
                      width: double.infinity, height: double.infinity),
                  errorWidget: (_, __, ___) =>
                      const Icon(Iconsax.image, color: TColors.darkGrey),
                ),
              ),
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
