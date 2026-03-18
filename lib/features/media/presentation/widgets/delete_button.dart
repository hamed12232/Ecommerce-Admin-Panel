import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.image,
  });

  final MediaImageModel image;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete Image'),
            content: Text('Are you sure you want to delete "${image.name}"?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete', style: TextStyle(color: TColors.error)),
              ),
            ],
          ),
        );
        if (confirmed == true && context.mounted) {
          context.read<MediaCubit>().deleteImage(image.path);
          Navigator.of(context).pop();
        }
      },
      child: const Text('Delete Image', style: TextStyle(color: TColors.error)),
    );
  }
}
