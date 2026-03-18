import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/repositories/base_media_repository.dart';

class FetchMediaImagesUseCase {
  final BaseMediaRepository _repository;

  FetchMediaImagesUseCase(this._repository);

  Future<Either<String, List<MediaImageModel>>> call({
    required String folder,
    int limit = 20,
    int offset = 0,
  }) {
    return _repository.listImages(folder: folder, limit: limit, offset: offset);
  }
}
