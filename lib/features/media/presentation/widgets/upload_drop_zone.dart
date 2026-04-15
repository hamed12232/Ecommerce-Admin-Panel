import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';

/// Drag-and-drop zone that shows an upload animation while uploading,
/// or a dropzone with a "Select Images" button otherwise.
class UploadDropZone extends StatefulWidget {
  const UploadDropZone({
    super.key,
    required this.isUploading,
    required this.onFilesReady,
  });

  final bool isUploading;
  final void Function(List<LocalMediaFile> files) onFilesReady;

  @override
  State<UploadDropZone> createState() => _UploadDropZoneState();
}

class _UploadDropZoneState extends State<UploadDropZone> {
  late DropzoneViewController _dropController;
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isHighlighted
            ? TColors.primary.withValues(alpha: 0.05)
            : TColors.lightGrey,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        border: Border.all(
          color: _isHighlighted ? TColors.primary : TColors.borderPrimary,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: widget.isUploading
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
                  onCreated: (controller) => _dropController = controller,
                  onDropFile: (value) => _handleDrop(value),
                  onHover: () => setState(() => _isHighlighted = true),
                  onLeave: () => setState(() => _isHighlighted = false),
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
                    const SizedBox(height: TSizes.spaceBtwItems),
                    OutlinedButton(
                      onPressed: () => _selectFiles(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.lg, vertical: TSizes.md),
                        side:
                            const BorderSide(color: TColors.borderPrimary),
                      ),
                      child: const Text('Select Images'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Future<void> _handleDrop(dynamic event) async {
    setState(() => _isHighlighted = false);
    final name = await _dropController.getFilename(event);
    final bytes = await _dropController.getFileData(event);
    widget.onFilesReady([LocalMediaFile(name: name, bytes: bytes)]);
  }

  Future<void> _selectFiles() async {
    final files = await _dropController.pickFiles(
        multiple: true,
        mime: ['image/jpeg', 'image/png', 'image/gif', 'image/webp']);
    if (files.isEmpty) return;

    final localFiles = <LocalMediaFile>[];
    for (final file in files) {
      final name = await _dropController.getFilename(file);
      final bytes = await _dropController.getFileData(file);
      localFiles.add(LocalMediaFile(name: name, bytes: bytes));
    }
    widget.onFilesReady(localFiles);
  }
}
