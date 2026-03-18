import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/data_sources/media_data_source.dart';

/// Dropdown to select the target Supabase storage folder.
class MediaFolderDropdown extends StatelessWidget {
  const MediaFolderDropdown({
    super.key,
    required this.selectedFolder,
    required this.onChanged,
  });

  final String selectedFolder;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final folders = MediaDataSource.folderMap.keys.toList();

    return DropdownButton<String>(
      value: selectedFolder,
      dropdownColor: TColors.white,
      focusColor: TColors.lightGrey,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      underline: const SizedBox.shrink(),
      borderRadius: BorderRadius.circular(8),
      items: folders
          .map((f) => DropdownMenuItem(value: f, child: Text(f)))
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
