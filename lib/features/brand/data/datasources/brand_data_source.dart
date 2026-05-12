import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';

class BrandDataSource extends BaseFirestoreDataSource {
  BrandDataSource() : super(collectionName: 'Brands');

  Future<List<Map<String, dynamic>>> getBrands() async {
    return getAll();
  }

  Future<Map<String, dynamic>?> getBrandById(String id) async {
    return getById(id);
  }

  Future<void> createBrand(Map<String, dynamic> brand) async {
    await create(brand['Id'] as String, brand);
  }

  Future<void> updateBrand(String id, Map<String, dynamic> brand) async {
    await update(id, brand);
  }

  Future<void> deleteBrand(String id) async {
    await delete(id);
  }
}
