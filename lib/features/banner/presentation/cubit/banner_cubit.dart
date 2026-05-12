import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/repositories/banner_repository.dart';

class BannerCubit extends BaseCubit<List<BannerModel>> {
  final BannerRepository _bannerRepository;

  BannerCubit(this._bannerRepository) : super();

  Future<void> fetchBanners({bool activeOnly = false}) async {
    emitLoading();
    final result = await _bannerRepository.getBanners(activeOnly: activeOnly);
    result.fold(
      (failure) => emitError(failure.message),
      (data) => emitSuccess(data),
    );
  }

  Future<void> createBanner(BannerModel banner) async {
    emitLoading();
    final result = await _bannerRepository.createBanner(banner);
    if (result.isRight()) {
      await fetchBanners();
    } else {
      result.fold((failure) => emitError(failure.message), (_) {});
    }
  }

  Future<void> updateBanner(BannerModel banner) async {
    emitLoading();
    final result = await _bannerRepository.updateBanner(banner);
    if (result.isRight()) {
      await fetchBanners();
    } else {
      result.fold((failure) => emitError(failure.message), (_) {});
    }
  }

  Future<void> deleteBanner(String id) async {
    emitLoading();
    final result = await _bannerRepository.deleteBanner(id);
    if (result.isRight()) {
      await fetchBanners();
    } else {
      result.fold((failure) => emitError(failure.message), (_) {});
    }
  }
}
