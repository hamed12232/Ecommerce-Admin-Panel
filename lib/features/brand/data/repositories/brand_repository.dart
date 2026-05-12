import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/datasources/brand_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/datasources/brand_category_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/datasources/category_data_source.dart';

class BrandRepository extends BaseRepository<BrandModel> {
  final BrandDataSource _dataSource;
  final BrandCategoryDataSource _brandCategoryDataSource;
  final CategoryDataSource _categoryDataSource;

  BrandRepository({
    required BrandDataSource dataSource,
    required BrandCategoryDataSource brandCategoryDataSource,
    required CategoryDataSource categoryDataSource,
  })  : _dataSource = dataSource,
        _brandCategoryDataSource = brandCategoryDataSource,
        _categoryDataSource = categoryDataSource,
        super(dataSource: dataSource);

  /// Fetches all brands and enriches them with category names from the
  /// `BrandCategory` junction collection.
  Future<Either<TExceptions, List<BrandModel>>> getBrands() async {
    try {
      final brandsData = await _dataSource.getBrands();
      final brands =
          brandsData.map((json) => BrandModel.fromJson(json)).toList();

      // Fetch all brand-category mappings in one go
      final allBrandCategories =
          await _brandCategoryDataSource.getAllBrandCategories();

      // Fetch all categories for name lookup
      final allCategories = await _categoryDataSource.getCategories();
      final categoryMap = {for (final c in allCategories) c.id: c.name};

      // Enrich each brand with its category names
      final enrichedBrands = brands.map((brand) {
        final linkedCategoryIds = allBrandCategories
            .where((bc) => bc['brandId'] == brand.id)
            .map((bc) => bc['categoryId'] as String)
            .toList();

        final categoryNames = linkedCategoryIds
            .map((id) => categoryMap[id])
            .where((name) => name != null)
            .cast<String>()
            .toSet()
            .toList();

        return brand.copyWith(categories: categoryNames);
      }).toList();

      return Right(enrichedBrands);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, BrandModel?>> getBrandById(String id) async {
    try {
      final data = await _dataSource.getBrandById(id);
      if (data == null) return const Right(null);

      final brand = BrandModel.fromJson(data);

      // Fetch category names for this brand
      final categoryIds =
          await _brandCategoryDataSource.getCategoryIdsForBrand(id);
      final allCategories = await _categoryDataSource.getCategories();
      final categoryMap = {for (final c in allCategories) c.id: c.name};

      final categoryNames = categoryIds
          .map((id) => categoryMap[id])
          .where((name) => name != null)
          .cast<String>()
          .toSet()
          .toList();

      return Right(brand.copyWith(categories: categoryNames));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, List<BrandModel>>> getBrandsForCategory(
      String categoryId) async {
    try {
      // Get brand IDs linked to this category from the junction collection
      final brandIds =
          await _brandCategoryDataSource.getBrandIdsForCategory(categoryId);
      if (brandIds.isEmpty) return const Right([]);

      // Fetch those brands
      final brandsData =
          await _dataSource.getByFieldList(field: 'Id', values: brandIds);
      final brands =
          brandsData.map((json) => BrandModel.fromJson(json)).toList();

      return Right(brands);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> createBrand(BrandModel brand) async {
    try {
      await _dataSource.createBrand(brand.toJson());
      // Sync the brand-category junction
      if (brand.categories.isNotEmpty) {
        // Resolve category names to IDs
        final allCategories = await _categoryDataSource.getCategories();
        final categoryIds = allCategories
            .where((c) => brand.categories.contains(c.name))
            .map((c) => c.id)
            .toList();

        await _brandCategoryDataSource.syncBrandCategories(
          brandId: brand.id,
          categoryIds: categoryIds,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> updateBrand(BrandModel brand) async {
    try {
      await _dataSource.updateBrand(brand.id, brand.toJson());
      // Sync the brand-category junction
      final allCategories = await _categoryDataSource.getCategories();
      final categoryIds = allCategories
          .where((c) => brand.categories.contains(c.name))
          .map((c) => c.id)
          .toList();

      await _brandCategoryDataSource.syncBrandCategories(
        brandId: brand.id,
        categoryIds: categoryIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> deleteBrand(String id) async {
    try {
      // Remove junction entries first
      await _brandCategoryDataSource.removeBrandCategories(id);
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
        return getBrandsForCategory(value as String);
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
        await _brandCategoryDataSource.removeBrandCategories(id);
        await _dataSource.deleteBrand(id);
      }
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
