import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_folder_dropdown.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_image_grid.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/upload_images_button.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/upload_images_dialog.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: TBreadcrumbsWithHeading(
                      heading: 'Media',
                      breadcrumbItems: [AppRoutes.media],
                      returnToPreviousScreen: true,
                    ),
                  ),
                  UploadImagesButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<MediaCubit>(),
                        child: const UploadImagesDialog(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Folder Selector
              BlocBuilder<MediaCubit, MediaState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      const Text('Gallery Folders'),
                      const SizedBox(width: TSizes.sm),
                      MediaFolderDropdown(
                        selectedFolder: state.selectedFolder,
                        onChanged: (folder) =>
                            context.read<MediaCubit>().selectFolder(folder),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Image Grid
              const MediaImageGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
