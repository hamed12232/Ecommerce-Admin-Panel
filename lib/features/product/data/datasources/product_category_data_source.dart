import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';

/// Data source for the `ProductCategory` junction collection in Firestore.
/// Each document has: { productId: "...", categoryId: "..." }
class ProductCategoryDataSource extends BaseFirestoreDataSource {
  ProductCategoryDataSource() : super(collectionName: 'ProductCategory');

  /// Get all category IDs linked to a specific product.
  Future<List<String>> getCategoryIdsForProduct(String productId) async {
    final data = await getByField(field: 'productId', value: productId);
    return data.map((e) => e['categoryId'] as String).toList();
  }

  /// Get all product IDs linked to a specific category.
  Future<List<String>> getProductIdsForCategory(String categoryId) async {
    final data = await getByField(field: 'categoryId', value: categoryId);
    return data.map((e) => e['productId'] as String).toList();
  }

  /// Get all product-category mappings.
  Future<List<Map<String, dynamic>>> getAllProductCategories() async {
    return getAll();
  }

  /// Link a product to a category.
  Future<void> addProductCategory({
    required String productId,
    required String categoryId,
  }) async {
    await createWithAutoId({
      'productId': productId,
      'categoryId': categoryId,
    });
  }

  /// Remove all category links for a product.
  Future<void> removeProductCategories(String productId) async {
    final data = await getByField(field: 'productId', value: productId);
    final ids = data.map((e) => e['id'] as String).toList();
    if (ids.isNotEmpty) {
      await deleteAll(ids);
    }
  }

  /// Sync categories for a product: removes old links and adds new ones.
  Future<void> syncProductCategories({
    required String productId,
    required List<String> categoryIds,
  }) async {
    // Remove existing links
    await removeProductCategories(productId);
    // Add new links
    for (final categoryId in categoryIds) {
      await addProductCategory(productId: productId, categoryId: categoryId);
    }
  }
}
