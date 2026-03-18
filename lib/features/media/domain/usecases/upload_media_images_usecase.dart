import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/repositories/base_media_repository.dart';

class UploadMediaImagesUseCase {
  final BaseMediaRepository _repository;

  UploadMediaImagesUseCase(this._repository);

  Future<Either<String, List<String>>> call({
    required String folder,
    required Map<String, Uint8List> files,
  }) {
    return _repository.uploadImages(folder: folder, files: files);
  }
}
