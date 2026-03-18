import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_folder_dropdown.dart';

/// Row containing folder selector, "Remove All", and "Upload" actions.
class UploadActionsRow extends StatelessWidget {
  const UploadActionsRow({
    super.key,
    required this.selectedFolder,
    required this.hasFiles,
    required this.isUploading,
    required this.onUpload,
  });

  final String selectedFolder;
  final bool hasFiles;
  final bool isUploading;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Select Folder'),
        const SizedBox(width: TSizes.sm),
        MediaFolderDropdown(
          selectedFolder: selectedFolder,
          onChanged: (folder) =>
              context.read<MediaCubit>().selectFolder(folder),
        ),
        const Spacer(),
        if (hasFiles) ...[
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
              onPressed: isUploading ? null : onUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: TSizes.md),
              ),
              child: isUploading
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
    );
  }
}
