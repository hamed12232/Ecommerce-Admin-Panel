import 'dart:typed_data';

import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';

enum MediaStatus { initial, loading, success, error }

/// Holds a file selected locally (before upload).
class LocalMediaFile {
  final String name;
  final Uint8List bytes;

  const LocalMediaFile({required this.name, required this.bytes});
}

class MediaState {
  final MediaStatus status;
  final List<MediaImageModel> images;
  final List<LocalMediaFile> localFiles;
  final String selectedFolder;
  final String? error;
  final bool isUploading;
  final bool canLoadMore;
  final int currentOffset;

  const MediaState({
    this.status = MediaStatus.initial,
    this.images = const [],
    this.localFiles = const [],
    this.selectedFolder = 'Brands',
    this.error,
    this.isUploading = false,
    this.canLoadMore = true,
    this.currentOffset = 0,
  });

  MediaState copyWith({
    MediaStatus? status,
    List<MediaImageModel>? images,
    List<LocalMediaFile>? localFiles,
    String? selectedFolder,
    String? error,
    bool? isUploading,
    bool? canLoadMore,
    int? currentOffset,
  }) {
    return MediaState(
      status: status ?? this.status,
      images: images ?? this.images,
      localFiles: localFiles ?? this.localFiles,
      selectedFolder: selectedFolder ?? this.selectedFolder,
      error: error ?? this.error,
      isUploading: isUploading ?? this.isUploading,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}
