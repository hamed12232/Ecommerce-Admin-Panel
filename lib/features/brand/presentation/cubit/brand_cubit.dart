import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/repositories/brand_repository.dart';

class BrandCubit extends BaseCubit<List<BrandModel>> {
  final BrandRepository _brandRepository;

  BrandCubit(this._brandRepository) : super();

  Future<void> fetchBrands() async {
    emitLoading();
    final result = await _brandRepository.getBrands();
    result.fold(
      (failure) => emitError(failure.message),
      (data) => emitSuccess(data),
    );
  }

  Future<void> createBrand(BrandModel brand) async {
    emitLoading();
    final result = await _brandRepository.createBrand(brand);
    result.fold(
      (failure) => emitError(failure.message),
      (_) => fetchBrands(),
    );
  }

  Future<void> updateBrand(BrandModel brand) async {
    emitLoading();
    final result = await _brandRepository.updateBrand(brand);
    result.fold(
      (failure) => emitError(failure.message),
      (_) => fetchBrands(),
    );
  }

  Future<void> deleteBrand(String id) async {
    emitLoading();
    final result = await _brandRepository.deleteBrand(id);
    result.fold(
      (failure) => emitError(failure.message),
      (_) => fetchBrands(),
    );
  }
}
