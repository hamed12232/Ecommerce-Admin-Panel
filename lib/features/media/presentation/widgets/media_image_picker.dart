import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/di/service_locator.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_picker_content.dart';

class MediaImagePicker {
  MediaImagePicker._();

  static Future<List<String>?> show({
    required BuildContext context,
    bool allowMultiple = true,
  }) async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => BlocProvider(
        create: (_) => getIt<MediaCubit>(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return MediaPickerContent(allowMultiple: allowMultiple);
          },
        ),
      ),
    );
    return result;
  }

  /// Convenience method for single-image selection.
  ///
  /// Returns the selected image URL, or `null` if dismissed.
  static Future<String?> showSingle({
    required BuildContext context,
  }) async {
    final result = await show(context: context, allowMultiple: false);
    if (result != null && result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
