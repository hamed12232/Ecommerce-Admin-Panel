import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/delete_button.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/image_preview.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/url_image.dart';

/// Dialog showing image preview, name, URL, copy, and delete.
class ImageDetailDialog extends StatelessWidget {
  const ImageDetailDialog({super.key, required this.image});

  final MediaImageModel image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Close Button ────────────────────────────
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),

              // ── Image Preview ──────────────────────────
              ImagePreview(image: image),

              const SizedBox(height: TSizes.spaceBtwItems),

              // ── Image Name ─────────────────────────────
              _infoRow(context, 'Image Name:', image.name),
              const SizedBox(height: TSizes.sm),

              // ── Image URL + Copy ───────────────────────
              UrlImage(image: image),

              const SizedBox(height: TSizes.spaceBtwItems),

              // ── Delete ─────────────────────────────────
              DeleteButton(image: image),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(width: TSizes.sm),
        Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
      ],
    );
  }
}
