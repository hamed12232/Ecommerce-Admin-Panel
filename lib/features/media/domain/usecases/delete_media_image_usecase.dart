import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/repositories/base_media_repository.dart';

class DeleteMediaImageUseCase {
  final BaseMediaRepository _repository;

  DeleteMediaImageUseCase(this._repository);

  Future<Either<String, void>> call(String path) {
    return _repository.deleteImage(path);
  }
}
