import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/datasources/product_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/datasources/product_category_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/datasources/category_data_source.dart';

class ProductRepository extends BaseRepository<ProductModel> {
  final ProductDataSource _dataSource;
  final ProductCategoryDataSource _productCategoryDataSource;
  final CategoryDataSource _categoryDataSource;

  ProductRepository({
    required ProductDataSource dataSource,
    required ProductCategoryDataSource productCategoryDataSource,
    required CategoryDataSource categoryDataSource,
  })  : _dataSource = dataSource,
        _productCategoryDataSource = productCategoryDataSource,
        _categoryDataSource = categoryDataSource,
        super(dataSource: dataSource);

  /// Fetches all products and enriches them with category names from the
  /// `ProductCategory` junction collection.
  Future<Either<TExceptions, List<ProductModel>>> getProducts() async {
    try {
      final data = await _dataSource.getProducts();
      final products = data.map((json) => ProductModel.fromJson(json)).toList();

      // Fetch all product-category mappings in one go
      final allProductCategories =
          await _productCategoryDataSource.getAllProductCategories();

      // Fetch all categories for name lookup
      final allCategories = await _categoryDataSource.getCategories();
      final categoryMap = {for (final c in allCategories) c.id: c.name};

      // Enrich each product with its category names
      final enrichedProducts = products.map((product) {
        final linkedCategoryIds = allProductCategories
            .where((pc) => pc['productId'] == product.id)
            .map((pc) => pc['categoryId'] as String)
            .toList();

        final categoryNames = linkedCategoryIds
            .map((id) => categoryMap[id])
            .where((name) => name != null)
            .cast<String>()
            .toList();

        return product.copyWith(categories: categoryNames);
      }).toList();

      return Right(enrichedProducts);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, ProductModel?>> getProductById(String id) async {
    try {
      final data = await _dataSource.getProductById(id);
      if (data == null) return const Right(null);

      final product = ProductModel.fromJson(data);

      // Fetch category names for this product
      final categoryIds =
          await _productCategoryDataSource.getCategoryIdsForProduct(id);
      final allCategories = await _categoryDataSource.getCategories();
      final categoryMap = {for (final c in allCategories) c.id: c.name};

      final categoryNames = categoryIds
          .map((id) => categoryMap[id])
          .where((name) => name != null)
          .cast<String>()
          .toList();

      return Right(product.copyWith(categories: categoryNames));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  /// Get products for a specific category via the junction table.
  Future<Either<TExceptions, List<ProductModel>>> getProductsForCategory(
      String categoryId) async {
    try {
      final productIds =
          await _productCategoryDataSource.getProductIdsForCategory(categoryId);
      if (productIds.isEmpty) return const Right([]);

      final productsData =
          await _dataSource.getByFieldList(field: 'id', values: productIds);
      final products =
          productsData.map((json) => ProductModel.fromJson(json)).toList();

      return Right(products);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> createProduct(ProductModel product) async {
    try {
      await _dataSource.createProduct(product.toJson());
      // Sync the product-category junction
      if (product.categories.isNotEmpty) {
        final allCategories = await _categoryDataSource.getCategories();
        final categoryIds = allCategories
            .where((c) => product.categories.contains(c.name))
            .map((c) => c.id)
            .toList();

        await _productCategoryDataSource.syncProductCategories(
          productId: product.id,
          categoryIds: categoryIds,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> updateProduct(ProductModel product) async {
    try {
      await _dataSource.updateProduct(product.id, product.toJson());
      // Sync the product-category junction
      final allCategories = await _categoryDataSource.getCategories();
      final categoryIds = allCategories
          .where((c) => product.categories.contains(c.name))
          .map((c) => c.id)
          .toList();

      await _productCategoryDataSource.syncProductCategories(
        productId: product.id,
        categoryIds: categoryIds,
      );
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  Future<Either<TExceptions, void>> deleteProduct(String id) async {
    try {
      // Remove junction entries first
      await _productCategoryDataSource.removeProductCategories(id);
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
      if (field == 'category' || field == 'categoryId') {
        return getProductsForCategory(value as String);
      }
      if (field == 'brand') {
        final data = await _dataSource.getProductsByBrand(value as String);
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
        await _productCategoryDataSource.removeProductCategories(id);
        await _dataSource.deleteProduct(id);
      }
      return const Right(null);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
