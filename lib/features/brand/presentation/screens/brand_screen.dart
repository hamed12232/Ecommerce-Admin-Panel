import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/widgets/brands_list_content.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete(
      desktop: BrandsListContent(),
    );
  }
}
