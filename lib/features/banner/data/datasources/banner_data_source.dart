import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';

class BannerDataSource extends BaseFirestoreDataSource {
  BannerDataSource() : super(collectionName: 'banners');

  Future<List<Map<String, dynamic>>> getBanners(
      {bool activeOnly = true}) async {
    if (activeOnly) {
      return getByField(field: 'isActive', value: true);
    }
    return getAll();
  }

  Future<Map<String, dynamic>?> getBannerById(String id) async {
    return getById(id);
  }

  Future<void> createBanner(Map<String, dynamic> banner) async {
    await create(banner['id'] as String, banner);
  }

  Future<void> updateBanner(String id, Map<String, dynamic> banner) async {
    await update(id, banner);
  }

  Future<void> deleteBanner(String id) async {
    await delete(id);
  }
}
