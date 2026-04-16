import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/repositories/category_repository.dart';

class CategoryCubit extends BaseCubit<List<CategoryModel>> {
  final CategoryRepository _categoryRepository;

  CategoryCubit(this._categoryRepository) : super();

  Future<void> fetchCategories() async {
    emitLoading();
    final result = await _categoryRepository.getAll();
    result.fold(
      (failure) => emitError(failure.message),
      (data) => emitSuccess(data),
    );
  }

  Future<void> fetchCategoriesByParentId(String parentId) async {
    emitLoading();
    final result = await _categoryRepository.getCategoriesByParentId(parentId);
    result.fold(
      (failure) => emitError(failure.message),
      (data) => emitSuccess(data),
    );
  }

  Future<void> createCategory(CategoryModel category) async {
    emitLoading();
    final result = await _categoryRepository.createCategory(category);
    result.fold(
      (failure) => emitError(failure.message),
      (_) => fetchCategories(),
    );
  }

  Future<void> updateCategory(CategoryModel category) async {
    emitLoading();
    final result = await _categoryRepository.updateCategory(category);
    result.fold(
      (failure) => emitError(failure.message),
      (_) => fetchCategories(),
    );
  }

  Future<void> deleteCategory(String id) async {
    emitLoading();
    final result = await _categoryRepository.deleteCategory(id);
    result.fold(
      (failure) => emitError(failure.message),
      (_) => fetchCategories(),
    );
  }
}
