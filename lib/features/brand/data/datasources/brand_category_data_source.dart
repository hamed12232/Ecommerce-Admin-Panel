import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';

/// Data source for the `BrandCategory` junction collection in Firestore.
/// Each document has: { brandId: "...", categoryId: "..." }
class BrandCategoryDataSource extends BaseFirestoreDataSource {
  BrandCategoryDataSource() : super(collectionName: 'BrandCategory');

  /// Get all category IDs linked to a specific brand.
  Future<List<String>> getCategoryIdsForBrand(String brandId) async {
    final data = await getByField(field: 'brandId', value: brandId);
    return data.map((e) => e['categoryId'] as String).toList();
  }

  /// Get all brand IDs linked to a specific category.
  Future<List<String>> getBrandIdsForCategory(String categoryId) async {
    final data = await getByField(field: 'categoryId', value: categoryId);
    return data.map((e) => e['brandId'] as String).toList();
  }

  /// Get all brand-category mappings.
  Future<List<Map<String, dynamic>>> getAllBrandCategories() async {
    return getAll();
  }

  /// Link a brand to a category.
  Future<void> addBrandCategory({
    required String brandId,
    required String categoryId,
  }) async {
    await createWithAutoId({
      'brandId': brandId,
      'categoryId': categoryId,
    });
  }

  /// Remove all category links for a brand.
  Future<void> removeBrandCategories(String brandId) async {
    final data = await getByField(field: 'brandId', value: brandId);
    final ids = data.map((e) => e['id'] as String).toList();
    if (ids.isNotEmpty) {
      await deleteAll(ids);
    }
  }

  /// Sync categories for a brand: removes old links and adds new ones.
  Future<void> syncBrandCategories({
    required String brandId,
    required List<String> categoryIds,
  }) async {
    // Remove existing links
    await removeBrandCategories(brandId);
    // Add new links
    for (final categoryId in categoryIds) {
      await addBrandCategory(brandId: brandId, categoryId: categoryId);
    }
  }
}
