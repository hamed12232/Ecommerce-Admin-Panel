import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/models/media_image_model.dart';

/// Data source for interacting with Supabase Storage (images bucket).
class MediaDataSource {
  final _storage = Supabase.instance.client.storage;

  static const String _bucket = 'images';

  /// Maps [MediaCategory] folder names used in the bucket.
  static const Map<String, String> folderMap = {
    'Banners': 'banners',
    'Brands': 'brands',
    'Categories': 'categories',
    'Products': 'products',
    'Users': 'Users',
  };

  /// Uploads a single image to [folder]/[fileName].
  Future<String> uploadImage({
    required String folder,
    required String fileName,
    required Uint8List bytes,
  }) async {
    final path = '$folder/$fileName';
    await _storage.from(_bucket).uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );
    return getImageUrl(path);
  }

  /// Lists images inside a [folder] with pagination.
  Future<List<MediaImageModel>> listImages({
    required String folder,
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _storage.from(_bucket).list(
          path: folder,
          searchOptions: SearchOptions(limit: limit, offset: offset),
        );

    // Filter out placeholder/.emptyFolderPlaceholder entries
    final files = response.where((f) => f.name != '.emptyFolderPlaceholder').toList();
    return files.map((file) {
      final fullPath = '$folder/${file.name}';
      final url = _storage.from(_bucket).getPublicUrl(fullPath);
      return MediaImageModel(
        name: file.name,
        url: url,
        path: fullPath,
        createdAt: file.createdAt,
      );
    }).toList();
  }

  /// Deletes an image at the given [path].
  Future<void> deleteImage(String path) async {
    await _storage.from(_bucket).remove([path]);
  }

  /// Returns the public URL for a given [path].
  String getImageUrl(String path) {
    return _storage.from(_bucket).getPublicUrl(path);
  }
}
