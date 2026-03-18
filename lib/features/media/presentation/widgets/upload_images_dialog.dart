import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/upload_actions_row.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/upload_drop_zone.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/upload_thumbnails_row.dart';

/// Full-screen dialog with drag-and-drop zone, folder selector, and upload.
class UploadImagesDialog extends StatelessWidget {
  const UploadImagesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: TSizes.xl, vertical: TSizes.xl),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
      child: BlocBuilder<MediaCubit, MediaState>(
        builder: (context, state) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900, maxHeight: 600),
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Header ─────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upload Images',
                          style: Theme.of(context).textTheme.headlineSmall),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // ── Drop Zone ──────────────────────────────
                  Expanded(
                    child: UploadDropZone(
                      isUploading: state.isUploading,
                      onFilesReady: (files) =>
                          context.read<MediaCubit>().addLocalFiles(files),
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  // ── Folder Selector + Actions Row ──────────
                  UploadActionsRow(
                    selectedFolder: state.selectedFolder,
                    hasFiles: state.localFiles.isNotEmpty,
                    isUploading: state.isUploading,
                    onUpload: () => _upload(context),
                  ),

                  // ── Thumbnails Row ─────────────────────────
                  UploadThumbnailsRow(files: state.localFiles),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _upload(BuildContext context) async {
    await context.read<MediaCubit>().uploadImages();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
