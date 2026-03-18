import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';

class UrlImage extends StatelessWidget {
  const UrlImage({
    super.key,
    required this.image,
  });

  final MediaImageModel image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Image URL:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(width: TSizes.sm),
        Expanded(
          child: Text(
            image.url,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: TSizes.sm),
        OutlinedButton(
          onPressed: () {
            FlutterClipboard.copy(image.url).then((_) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('URL copied to clipboard!')),
                );
              }
            });
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.sm),
            side: const BorderSide(color: TColors.borderPrimary),
          ),
          child: const Text('Copy URL'),
        ),
      ],
    );
  }
}
