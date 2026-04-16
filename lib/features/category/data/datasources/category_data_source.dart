import 'package:yt_ecommerce_admin_panel/core/data/datasources/firestore_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';

class CategoryDataSource extends BaseFirestoreDataSource {
  CategoryDataSource() : super(collectionName: 'categories');

  Future<List<CategoryModel>> getCategories(
      {String? orderBy, bool descending = false}) async {
    final data = await getAll(orderBy: orderBy, descending: descending);
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<CategoryModel?> getCategoryById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return CategoryModel.fromJson(data);
  }

  Future<List<CategoryModel>> getCategoriesByParentId(String parentId) async {
    final data = await getByField(field: 'parentId', value: parentId);
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<void> createCategory(CategoryModel category) async {
    await create(category.id, category.toJson());
  }

  Future<void> updateCategory(CategoryModel category) async {
    await update(category.id, category.toJson());
  }

  Future<void> deleteCategory(String id) async {
    await delete(id);
  }
}
