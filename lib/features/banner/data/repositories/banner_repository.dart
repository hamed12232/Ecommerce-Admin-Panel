import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/datasources/banner_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/models/banner_model.dart';

class BannerRepository extends BaseRepository<BannerModel> {
  final BannerDataSource _dataSource;

  BannerRepository({required BannerDataSource dataSource})
      : _dataSource = dataSource,
        super(dataSource: dataSource);

  Future<Either<TExceptions, List<BannerModel>>> getBanners(
      {bool activeOnly = true}) async {
    try {
      final data = await _dataSource.getBanners(activeOnly: activeOnly);
      return Right(data.map((json) => BannerModel.fromJson(json)).toList());
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, BannerModel?>> getBannerById(String id) async {
    try {
      final data = await _dataSource.getBannerById(id);
      if (data == null) return const Right(null);
      return Right(BannerModel.fromJson(data));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> createBanner(BannerModel banner) async {
    try {
      await _dataSource.createBanner(banner.toJson());
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> updateBanner(BannerModel banner) async {
    try {
      await _dataSource.updateBanner(banner.id, banner.toJson());
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> deleteBanner(String id) async {
    try {
      await _dataSource.deleteBanner(id);
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, List<BannerModel>>> getAll() => getBanners();

  @override
  Future<Either<TExceptions, BannerModel?>> getById(String id) =>
      getBannerById(id);

  @override
  Future<Either<TExceptions, List<BannerModel>>> getByField(
      String field, dynamic value) async {
    try {
      final data = await _dataSource.getByField(field: field, value: value);
      return Right(data.map((json) => BannerModel.fromJson(json)).toList());
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> create(BannerModel entity) =>
      createBanner(entity);

  @override
  Future<Either<TExceptions, void>> update(String id, BannerModel entity) =>
      updateBanner(entity);

  @override
  Future<Either<TExceptions, void>> delete(String id) => deleteBanner(id);

  @override
  Future<Either<TExceptions, void>> deleteAll(List<String> ids) async {
    try {
      for (final id in ids) {
        await _dataSource.deleteBanner(id);
      }
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
