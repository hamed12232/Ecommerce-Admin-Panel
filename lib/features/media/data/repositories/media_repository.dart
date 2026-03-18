import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/data_sources/media_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/repositories/base_media_repository.dart';

class MediaRepository implements BaseMediaRepository {
  final MediaDataSource _dataSource;

  MediaRepository(this._dataSource);

  @override
  Future<Either<String, List<String>>> uploadImages({
    required String folder,
    required Map<String, Uint8List> files,
  }) async {
    try {
      final urls = <String>[];
      for (final entry in files.entries) {
        final url = await _dataSource.uploadImage(
          folder: folder,
          fileName: entry.key,
          bytes: entry.value,
        );
        urls.add(url);
      }
      return Right(urls);
    } catch (e) {
      return Left('Upload failed: $e');
    }
  }

  @override
  Future<Either<String, List<MediaImageModel>>> listImages({
    required String folder,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final images = await _dataSource.listImages(
        folder: folder,
        limit: limit,
        offset: offset,
      );
      return Right(images);
    } catch (e) {
      return Left('Failed to load images: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteImage(String path) async {
    try {
      await _dataSource.deleteImage(path);
      return const Right(null);
    } catch (e) {
      return Left('Delete failed: $e');
    }
  }
}
