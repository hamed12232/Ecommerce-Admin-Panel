import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/repositories/product_repository.dart';

class ProductCubit extends BaseCubit<List<ProductModel>> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super();

  Future<void> fetchProducts() async {
    emitLoading();
    final result = await _productRepository.getProducts();
    result.fold(
      (failure) => emitError(failure.message),
      (data) => emitSuccess(data),
    );
  }

  Future<void> createProduct(ProductModel product) async {
    emitLoading();
    final result = await _productRepository.createProduct(product);
    if (result.isRight()) {
      await fetchProducts();
    } else {
      result.fold((failure) => emitError(failure.message), (_) {});
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    emitLoading();
    final result = await _productRepository.updateProduct(product);
    if (result.isRight()) {
      await fetchProducts();
    } else {
      result.fold((failure) => emitError(failure.message), (_) {});
    }
  }

  Future<void> deleteProduct(String id) async {
    emitLoading();
    final result = await _productRepository.deleteProduct(id);
    if (result.isRight()) {
      await fetchProducts();
    } else {
      result.fold((failure) => emitError(failure.message), (_) {});
    }
  }
}
