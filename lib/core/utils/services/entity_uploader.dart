import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';

abstract class UploadableEntity {
  String get imageUrl;
  List<String>? get additionalImages;
  String get entityId;
  Map<String, String> get nestedImagePaths;
  UploadableEntity copyWithImageUrl(String newImageUrl);
  UploadableEntity copyWithAdditionalImages(List<String> newImages);
  UploadableEntity copyWithNestedImages(Map<String, String> uploadedUrls);
}

class UploadResult<T extends UploadableEntity> {
  final bool success;
  final String? errorMessage;
  final T? updatedEntity;

  const UploadResult._({
    required this.success,
    this.errorMessage,
    this.updatedEntity,
  });

  factory UploadResult.success(T entity) => UploadResult._(
        success: true,
        updatedEntity: entity,
      );

  factory UploadResult.error(String message) => UploadResult._(
        success: false,
        errorMessage: message,
      );

  factory UploadResult.noInternet() => const UploadResult._(
        success: false,
        errorMessage: 'No Internet Connection',
      );
}

class ImageUploaderConfig {
  final String storageFolderName;
  final String fileExtension;

  const ImageUploaderConfig({
    required this.storageFolderName,
    this.fileExtension = 'png',
  });
}

class EntityUploader<T extends UploadableEntity> {
  final Future<Either<TExceptions, String>> Function(String path, File file)
      uploadImage;
  final Future<Either<TExceptions, void>> Function(UploadableEntity entity)
      saveEntity;
  final ImageUploaderConfig config;

  EntityUploader({
    required this.uploadImage,
    required this.saveEntity,
    required this.config,
  });

  Future<bool> _isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return !result.any((e) => e == ConnectivityResult.none);
  }

  Future<UploadResult<T>> uploadWithImage(T entity) async {
    final isConnected = await _isConnected();
    if (!isConnected) return UploadResult.noInternet();

    try {
      String imageUrl = entity.imageUrl;
      if (imageUrl.startsWith('assets/')) {
        imageUrl = await _uploadSingleImage(imageUrl, entity.entityId);
      }

      List<String> updatedAdditionalImages = [];
      if (entity.additionalImages != null &&
          entity.additionalImages!.isNotEmpty) {
        int index = 0;
        for (var img in entity.additionalImages!) {
          if (img.startsWith('assets/')) {
            final uploadedUrl =
                await _uploadSingleImage(img, '${entity.entityId}_$index');
            updatedAdditionalImages.add(uploadedUrl);
          } else {
            updatedAdditionalImages.add(img);
          }
          index++;
        }
      }

      Map<String, String> uploadedNestedUrls = {};
      final nestedPaths = entity.nestedImagePaths;
      for (var entry in nestedPaths.entries) {
        if (entry.value.isNotEmpty && entry.value.startsWith('assets/')) {
          final uploadedUrl = await _uploadSingleImage(
              entry.value, '${entity.entityId}_${entry.key}');
          uploadedNestedUrls[entry.key] = uploadedUrl;
        } else {
          uploadedNestedUrls[entry.key] = entry.value;
        }
      }

      var updatedEntity = entity.copyWithImageUrl(imageUrl);
      if (updatedAdditionalImages.isNotEmpty) {
        updatedEntity =
            updatedEntity.copyWithAdditionalImages(updatedAdditionalImages);
      }
      if (uploadedNestedUrls.isNotEmpty) {
        updatedEntity = updatedEntity.copyWithNestedImages(uploadedNestedUrls);
      }

      final result = await saveEntity(updatedEntity);
      return result.fold(
        (failure) => UploadResult.error(failure.message),
        (_) => UploadResult.success(updatedEntity as T),
      );
    } catch (e) {
      return UploadResult.error('Failed to upload: ${e.toString()}');
    }
  }

  Future<String> _uploadSingleImage(String assetPath, String imageName) async {
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final fileName = '$imageName.${config.fileExtension}';
    final file = await File('${tempDir.path}/$fileName').create();
    await file.writeAsBytes(bytes);

    final uploadResult = await uploadImage(
      '${config.storageFolderName}/$fileName',
      file,
    );

    if (await file.exists()) await file.delete();

    return uploadResult.fold(
      (failure) => throw Exception(failure.message),
      (url) => url,
    );
  }
}

Future<Either<TExceptions, String>> uploadImageToSupabase(
  String path,
  File file,
) async {
  try {
    final bucket = Supabase.instance.client.storage.from('images');
    final response = await bucket.upload(
      path,
      file,
      fileOptions: const FileOptions(upsert: true),
    );
    if (response.isEmpty) throw Exception('Upload failed');
    final publicUrl = bucket.getPublicUrl(path);
    return Right(publicUrl);
  } catch (e) {
    return Left(TExceptions(e.toString()));
  }
}
