import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/presentation/widgets/create_banner_content.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key, this.banner});

  /// Pass a [BannerModel] to enter edit mode.
  final BannerModel? banner;

  @override
  Widget build(BuildContext context) {
    return SiteTemplete(
      desktop: CreateBannerContent(banner: banner),
    );
  }
}
