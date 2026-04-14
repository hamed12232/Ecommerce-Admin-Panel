import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/presentation/widgets/banners_list_content.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete(
      desktop: BannersListContent(),
    );
  }
}
