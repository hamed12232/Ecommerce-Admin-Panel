import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';

class BrandDataSource extends BaseFirestoreDataSource {
  BrandDataSource() : super(collectionName: 'brands');

  Future<List<Map<String, dynamic>>> getBrands() async {
    return getAll();
  }

  Future<Map<String, dynamic>?> getBrandById(String id) async {
    return getById(id);
  }

  Future<List<Map<String, dynamic>>> getBrandsForCategory(
      String categoryId) async {
    final brandCategoryData =
        await getByField(field: 'categoryId', value: categoryId);
    final brandIds =
        brandCategoryData.map((e) => e['brandId'] as String).toList();
    if (brandIds.isEmpty) return [];
    return getByFieldList(field: 'id', values: brandIds);
  }

  Future<void> createBrand(Map<String, dynamic> brand) async {
    await create(brand['id'] as String, brand);
  }

  Future<void> updateBrand(String id, Map<String, dynamic> brand) async {
    await update(id, brand);
  }

  Future<void> deleteBrand(String id) async {
    await delete(id);
  }
}
