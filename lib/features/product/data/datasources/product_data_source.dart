import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';

class ProductDataSource extends BaseFirestoreDataSource {
  ProductDataSource() : super(collectionName: 'products');

  Future<List<Map<String, dynamic>>> getProducts() async {
    return getAll();
  }

  Future<Map<String, dynamic>?> getProductById(String id) async {
    return getById(id);
  }

  Future<List<Map<String, dynamic>>> getProductsByBrand(String brandId) async {
    return getByField(field: 'brandId', value: brandId);
  }

  Future<List<Map<String, dynamic>>> getProductsByCategory(
      String categoryName) async {
    return getByField(field: 'category', value: categoryName);
  }

  Future<void> createProduct(Map<String, dynamic> product) async {
    await create(product['id'] as String, product);
  }

  Future<void> updateProduct(String id, Map<String, dynamic> product) async {
    await update(id, product);
  }

  Future<void> deleteProduct(String id) async {
    await delete(id);
  }
}
