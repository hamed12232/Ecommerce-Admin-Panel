import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_folder_dropdown.dart';

/// Full-screen dialog with drag-and-drop zone, folder selector, and upload.
class UploadImagesDialog extends StatefulWidget {
  const UploadImagesDialog({super.key});
  @override
  State<UploadImagesDialog> createState() => _UploadImagesDialogState();
}

class _UploadImagesDialogState extends State<UploadImagesDialog> {
  late DropzoneViewController _dropController;
  bool _isHighlighted = false;

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
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHighlighted
                            ? TColors.primary.withOpacity(0.05)
                            : TColors.lightGrey,
                        borderRadius:
                            BorderRadius.circular(TSizes.borderRadiusMd),
                        border: Border.all(
                          color: _isHighlighted
                              ? TColors.primary
                              : TColors.borderPrimary,
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      child: state.isUploading
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    TImages.uploadingImageIllustration,
                                    height: 250,
                                    width: 250,
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  Text(
                                    'Uploading...',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: TColors.primary),
                                  ),
                                ],
                              ),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                DropzoneView(
                                  onCreated: (controller) =>
                                      _dropController = controller,
                                  onDropFile: (value) =>
                                      _handleDrop(value, context),
                                //  onDropFiles: (values) =>
                                    //  _handleDropMultiple(values, context),
                                  onHover: () =>
                                      setState(() => _isHighlighted = true),
                                  onLeave: () =>
                                      setState(() => _isHighlighted = false),
                                  mime: const [
                                    'image/jpeg',
                                    'image/png',
                                    'image/gif',
                                    'image/webp'
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Iconsax.image,
                                        size: 48, color: TColors.darkGrey),
                                    const SizedBox(height: TSizes.sm),
                                    Text(
                                      'Drag and Drop Images here',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: TColors.darkGrey),
                                    ),
                                    const SizedBox(
                                        height: TSizes.spaceBtwItems),
                                    OutlinedButton(
                                      onPressed: () => _selectFiles(context),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: TSizes.lg,
                                            vertical: TSizes.md),
                                        side: const BorderSide(
                                            color: TColors.borderPrimary),
                                      ),
                                      child: const Text('Select Images'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  // ── Folder Selector + Actions Row ──────────
                  Row(
                    children: [
                      const Text('Select Folder'),
                      const SizedBox(width: TSizes.sm),
                      MediaFolderDropdown(
                        selectedFolder: state.selectedFolder,
                        onChanged: (folder) =>
                            context.read<MediaCubit>().selectFolder(folder),
                      ),
                      const Spacer(),
                      if (state.localFiles.isNotEmpty) ...[
                        TextButton(
                          onPressed: () =>
                              context.read<MediaCubit>().removeAllLocalFiles(),
                          child: const Text('Remove All',
                              style: TextStyle(color: TColors.darkGrey)),
                        ),
                        const SizedBox(width: TSizes.sm),
                        SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: state.isUploading
                                ? null
                                : () => _upload(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: TSizes.md),
                            ),
                            child: state.isUploading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white),
                                  )
                                : const Text('Upload'),
                          ),
                        ),
                      ],
                    ],
                  ),

                  // ── Thumbnails Row ─────────────────────────
                  if (state.localFiles.isNotEmpty) ...[
                    const SizedBox(height: TSizes.spaceBtwItems),
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.localFiles.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: TSizes.sm),
                        itemBuilder: (_, index) {
                          final file = state.localFiles[index];
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    TSizes.borderRadiusSm),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleDrop(dynamic event, BuildContext context) async {
    setState(() => _isHighlighted = false);
    final name = await _dropController.getFilename(event);
    final bytes = await _dropController.getFileData(event);
    if (!context.mounted) return;
    context
        .read<MediaCubit>()
        .addLocalFiles([LocalMediaFile(name: name, bytes: bytes)]);
  }

  // Future<void> _handleDropMultiple(
  //     List<dynamic>? events, BuildContext context) async {
  //   if (events == null || events.isEmpty) return;
  //   setState(() => _isHighlighted = false);
  //   final localFiles = <LocalMediaFile>[];
  //   for (final event in events) {
  //     final name = await _dropController.getFilename(event);
  //     final bytes = await _dropController.getFileData(event);
  //     localFiles.add(LocalMediaFile(name: name, bytes: bytes));
  //   }
  //   if (!context.mounted) return;
  //   context.read<MediaCubit>().addLocalFiles(localFiles);
  // }

  Future<void> _selectFiles(BuildContext context) async {
    final files = await _dropController.pickFiles(
        multiple: true,
        mime: ['image/jpeg', 'image/png', 'image/gif', 'image/webp']);
    if (files.isEmpty || !context.mounted) return;

    final localFiles = <LocalMediaFile>[];
    for (final file in files) {
      final name = await _dropController.getFilename(file);
      final bytes = await _dropController.getFileData(file);
      localFiles.add(LocalMediaFile(name: name, bytes: bytes));
    }
    if (!context.mounted) return;
    context.read<MediaCubit>().addLocalFiles(localFiles);
  }

  Future<void> _upload(BuildContext context) async {
    await context.read<MediaCubit>().uploadImages();
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
