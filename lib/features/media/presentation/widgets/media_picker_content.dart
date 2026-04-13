import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_folder_dropdown.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/selectable_media_image_grid.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/upload_drop_zone.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/upload_thumbnails_row.dart';

/// Bottom-sheet body for the reusable media image picker.
///
/// Shows an upload drop zone at the top, a folder selector, and a selectable
/// image grid. Returns the selected URLs when the user presses "Add".
class MediaPickerContent extends StatefulWidget {
  const MediaPickerContent({
    super.key,
    this.allowMultiple = true,
  });

  final bool allowMultiple;

  @override
  State<MediaPickerContent> createState() => _MediaPickerContentState();
}

class _MediaPickerContentState extends State<MediaPickerContent> {
  final Set<String> _selectedUrls = {};

  void _toggleSelection(String url) {
    setState(() {
      if (widget.allowMultiple) {
        if (_selectedUrls.contains(url)) {
          _selectedUrls.remove(url);
        } else {
          _selectedUrls.add(url);
        }
      } else {
        // Single-select mode: replace the selection
        if (_selectedUrls.contains(url)) {
          _selectedUrls.clear();
        } else {
          _selectedUrls
            ..clear()
            ..add(url);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Upload Drop Zone ────────────────────
                    SizedBox(
                      height: 180,
                      child: UploadDropZone(
                        isUploading: state.isUploading,
                        onFilesReady: (files) =>
                            context.read<MediaCubit>().addLocalFiles(files),
                      ),
                    ),

                    // ── Upload Thumbnails ───────────────────
                    UploadThumbnailsRow(files: state.localFiles),

                    // ── Upload button row (when files are pending) ─
                    if (state.localFiles.isNotEmpty) ...[
                      const SizedBox(height: TSizes.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => context
                                .read<MediaCubit>()
                                .removeAllLocalFiles(),
                            child: const Text('Remove All',
                                style: TextStyle(color: TColors.darkGrey)),
                          ),
                          const SizedBox(width: TSizes.sm),
                          SizedBox(
                            width: 110,
                            child: ElevatedButton(
                              onPressed: state.isUploading
                                  ? null
                                  : () =>
                                      context.read<MediaCubit>().uploadImages(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: TColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: TSizes.sm),
                              ),
                              child: state.isUploading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.white),
                                    )
                                  : const Text('Upload'),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const Divider(height: TSizes.spaceBtwSections),

                    // ── Header Row: Folder + Actions ────────
                    Row(
                      children: [
                        const Text('Media Folders',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: TSizes.sm),
                        MediaFolderDropdown(
                          selectedFolder: state.selectedFolder,
                          onChanged: (folder) =>
                              context.read<MediaCubit>().selectFolder(folder),
                        ),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Iconsax.close_circle, size: 18),
                          label: const Text('Close'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: TColors.darkGrey,
                            side:
                                const BorderSide(color: TColors.borderPrimary),
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.md, vertical: TSizes.sm),
                          ),
                        ),
                        const SizedBox(width: TSizes.sm),
                        ElevatedButton.icon(
                          onPressed: _selectedUrls.isEmpty
                              ? null
                              : () => Navigator.of(context)
                                  .pop(_selectedUrls.toList()),
                          icon: const Icon(Iconsax.add_circle, size: 18),
                          label: Text(
                            _selectedUrls.isEmpty
                                ? 'Add'
                                : 'Add (${_selectedUrls.length})',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: TColors.buttonDisabled,
                            disabledForegroundColor: Colors.white70,
                            padding: const EdgeInsets.symmetric(
                                horizontal: TSizes.md, vertical: TSizes.sm),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // ── Selectable Image Grid ──────────────
                    SelectableMediaImageGrid(
                      selectedUrls: _selectedUrls,
                      onToggle: _toggleSelection,
                      allowMultiple: widget.allowMultiple,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
