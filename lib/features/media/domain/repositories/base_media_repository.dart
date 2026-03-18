import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';

/// Abstract interface for media storage operations.
abstract class BaseMediaRepository {
  Future<Either<String, List<String>>> uploadImages({
    required String folder,
    required Map<String, Uint8List> files,
  });

  Future<Either<String, List<MediaImageModel>>> listImages({
    required String folder,
    int limit = 20,
    int offset = 0,
  });

  Future<Either<String, void>> deleteImage(String path);
}
