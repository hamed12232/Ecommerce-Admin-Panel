import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/datasources/product_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';

class ProductRepository extends BaseRepository<ProductModel> {
  final ProductDataSource _dataSource;

  ProductRepository({required ProductDataSource dataSource})
      : _dataSource = dataSource,
        super(dataSource: dataSource);

  Future<Either<TExceptions, List<ProductModel>>> getProducts() async {
    try {
      final data = await _dataSource.getProducts();
      return Right(data.map((json) => ProductModel.fromJson(json)).toList());
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, ProductModel?>> getProductById(String id) async {
    try {
      final data = await _dataSource.getProductById(id);
      if (data == null) return const Right(null);
      return Right(ProductModel.fromJson(data));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> createProduct(ProductModel product) async {
    try {
      await _dataSource.createProduct(product.toJson());
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> updateProduct(ProductModel product) async {
    try {
      await _dataSource.updateProduct(product.id, product.toJson());
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> deleteProduct(String id) async {
    try {
      await _dataSource.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<ProductModel>>> getAll() => getProducts();

  @override
  Future<Either<TExceptions, ProductModel?>> getById(String id) =>
      getProductById(id);

  @override
  Future<Either<TExceptions, List<ProductModel>>> getByField(
      String field, dynamic value) async {
    try {
      if (field == 'brand') {
        final data = await _dataSource.getProductsByBrand(value as String);
        return Right(data.map((json) => ProductModel.fromJson(json)).toList());
      }
      if (field == 'category') {
        final data = await _dataSource.getProductsByCategory(value as String);
        return Right(data.map((json) => ProductModel.fromJson(json)).toList());
      }
      final data = await _dataSource.getByField(field: field, value: value);
      return Right(data.map((json) => ProductModel.fromJson(json)).toList());
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> create(ProductModel entity) =>
      createProduct(entity);

  @override
  Future<Either<TExceptions, void>> update(String id, ProductModel entity) =>
      updateProduct(entity);

  @override
  Future<Either<TExceptions, void>> delete(String id) => deleteProduct(id);

  @override
  Future<Either<TExceptions, void>> deleteAll(List<String> ids) async {
    try {
      for (final id in ids) {
        await _dataSource.deleteProduct(id);
      }
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
