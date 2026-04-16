import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/datasources/brand_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';

class BrandRepository extends BaseRepository<BrandModel> {
  final BrandDataSource _dataSource;

  BrandRepository({required BrandDataSource dataSource})
      : _dataSource = dataSource,
        super(dataSource: dataSource);

  Future<Either<TExceptions, List<BrandModel>>> getBrands() async {
    try {
      final data = await _dataSource.getBrands();
      return Right(data.map((json) => BrandModel.fromJson(json)).toList());
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, BrandModel?>> getBrandById(String id) async {
    try {
      final data = await _dataSource.getBrandById(id);
      if (data == null) return const Right(null);
      return Right(BrandModel.fromJson(data));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, List<BrandModel>>> getBrandsForCategory(
      String categoryId) async {
    try {
      final data = await _dataSource.getBrandsForCategory(categoryId);
      return Right(data.map((json) => BrandModel.fromJson(json)).toList());
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> createBrand(BrandModel brand) async {
    try {
      await _dataSource.createBrand(brand.toJson());
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> updateBrand(BrandModel brand) async {
    try {
      await _dataSource.updateBrand(brand.id, brand.toJson());
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> deleteBrand(String id) async {
    try {
      await _dataSource.deleteBrand(id);
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<BrandModel>>> getAll() => getBrands();

  @override
  Future<Either<TExceptions, BrandModel?>> getById(String id) =>
      getBrandById(id);

  @override
  Future<Either<TExceptions, List<BrandModel>>> getByField(
      String field, dynamic value) async {
    try {
      if (field == 'categoryId') {
        final data = await _dataSource.getBrandsForCategory(value as String);
        return Right(data.map((json) => BrandModel.fromJson(json)).toList());
      }
      final data = await _dataSource.getByField(field: field, value: value);
      return Right(data.map((json) => BrandModel.fromJson(json)).toList());
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> create(BrandModel entity) =>
      createBrand(entity);

  @override
  Future<Either<TExceptions, void>> update(String id, BrandModel entity) =>
      updateBrand(entity);

  @override
  Future<Either<TExceptions, void>> delete(String id) => deleteBrand(id);

  @override
  Future<Either<TExceptions, void>> deleteAll(List<String> ids) async {
    try {
      for (final id in ids) {
        await _dataSource.deleteBrand(id);
      }
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
