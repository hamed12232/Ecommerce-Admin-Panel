import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_state.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/data_sources/media_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/usecases/delete_media_image_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/usecases/fetch_media_images_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/usecases/upload_media_images_usecase.dart';

class MediaCubit extends Cubit<MediaState> {
  final UploadMediaImagesUseCase _uploadUseCase;
  final FetchMediaImagesUseCase _fetchUseCase;
  final DeleteMediaImageUseCase _deleteUseCase;

  static const int _pageSize = 20;

  MediaCubit({
    required UploadMediaImagesUseCase uploadUseCase,
    required FetchMediaImagesUseCase fetchUseCase,
    required DeleteMediaImageUseCase deleteUseCase,
  })  : _uploadUseCase = uploadUseCase,
        _fetchUseCase = fetchUseCase,
        _deleteUseCase = deleteUseCase,
        super(const MediaState()) {
        loadImages();
  }

  /// Gets the bucket folder name for the currently selected UI folder.
  String get _bucketFolder =>
      MediaDataSource.folderMap[state.selectedFolder] ?? state.selectedFolder.toLowerCase();

  // ─── Folder Selection ──────────────────────────────────────────

  void selectFolder(String folder) {
    emit(state.copyWith(
      selectedFolder: folder,
      images: [],
      currentOffset: 0,
      canLoadMore: true,
      status: MediaStatus.loading,
    ));
    loadImages();
  }

  // ─── Load Images (initial + pagination) ────────────────────────

  Future<void> loadImages() async {
    if (state.status != MediaStatus.loading) {
      emit(state.copyWith(status: MediaStatus.loading));
    }

    final result = await _fetchUseCase(
      folder: _bucketFolder,
      limit: _pageSize,
      offset: 0,
    );

    result.fold(
      (error) => emit(state.copyWith(status: MediaStatus.error, error: error)),
      (images) => emit(state.copyWith(
        status: MediaStatus.success,
        images: images,
        currentOffset: images.length,
        canLoadMore: images.length >= _pageSize,
      )),
    );
  }

  Future<void> loadMore() async {
    if (!state.canLoadMore) return;

    final result = await _fetchUseCase(
      folder: _bucketFolder,
      limit: _pageSize,
      offset: state.currentOffset,
    );

    result.fold(
      (error) => emit(state.copyWith(error: error)),
      (newImages) => emit(state.copyWith(
        images: [...state.images, ...newImages],
        currentOffset: state.currentOffset + newImages.length,
        canLoadMore: newImages.length >= _pageSize,
      )),
    );
  }

  // ─── Local File Management (before upload) ─────────────────────

  void addLocalFiles(List<LocalMediaFile> files) {
    emit(state.copyWith(localFiles: [...state.localFiles, ...files]));
  }

  void removeLocalFile(int index) {
    final updated = [...state.localFiles]..removeAt(index);
    emit(state.copyWith(localFiles: updated));
  }

  void removeAllLocalFiles() {
    emit(state.copyWith(localFiles: []));
  }

  // ─── Upload to Supabase ────────────────────────────────────────

  Future<void> uploadImages({String? folder}) async {
    if (state.localFiles.isEmpty) return;

    final targetFolder = folder ?? state.selectedFolder;

    emit(state.copyWith(isUploading: true));

    final fileMap = <String, Uint8List>{};
    for (final file in state.localFiles) {
      fileMap[file.name] = file.bytes;
    }

    final result = await _uploadUseCase(
      folder: _bucketFolder,
      files: fileMap,
    );

    result.fold(
      (error) => emit(state.copyWith(isUploading: false, error: error)),
      (_) {
        emit(state.copyWith(isUploading: false, localFiles: []));
        // Refresh the gallery if we uploaded to the currently viewed folder
        if (targetFolder == state.selectedFolder) {
          loadImages();
        }
      },
    );
  }

  // ─── Delete Image ──────────────────────────────────────────────

  Future<void> deleteImage(String path) async {
    final result = await _deleteUseCase(path);

    result.fold(
      (error) => emit(state.copyWith(error: error)),
      (_) {
        final updatedImages = state.images.where((img) => img.path != path).toList();
        emit(state.copyWith(images: updatedImages));
      },
    );
  }
}
