import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/datasources/category_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';

class CategoryRepository extends BaseRepository<CategoryModel> {
  final CategoryDataSource _dataSource;

  CategoryRepository({required CategoryDataSource dataSource})
      : _dataSource = dataSource,
        super(dataSource: dataSource);

  @override
  Future<Either<TExceptions, List<CategoryModel>>> getAll() async {
    try {
      final data = await _dataSource.getCategories();
      return Right(data);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, CategoryModel?>> getById(String id) async {
    try {
      final data = await _dataSource.getCategoryById(id);
      return Right(data);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<CategoryModel>>> getByField(
      String field, dynamic value) async {
    try {
      if (field == 'parentId') {
        final data = await _dataSource.getCategoriesByParentId(value as String);
        return Right(data);
      }
      return const Right([]);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> create(CategoryModel entity) async {
    try {
      await _dataSource.createCategory(entity);
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> update(
      String id, CategoryModel entity) async {
    try {
      await _dataSource.updateCategory(entity);
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> delete(String id) async {
    try {
      await _dataSource.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> deleteAll(List<String> ids) async {
    try {
      await _dataSource.deleteAll(ids);
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, List<CategoryModel>>> getCategoriesByParentId(
      String parentId) async {
    try {
      final data = await _dataSource.getCategoriesByParentId(parentId);
      return Right(data);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> createCategory(CategoryModel category) =>
      create(category);

  Future<Either<TExceptions, void>> updateCategory(CategoryModel category) =>
      update(category.id, category);

  Future<Either<TExceptions, void>> deleteCategory(String id) => delete(id);
}
