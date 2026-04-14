import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/widgets/create_brand_content.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key, this.brand});

  /// Pass a [BrandModel] to enter edit mode.
  final BrandModel? brand;

  @override
  Widget build(BuildContext context) {
    return SiteTemplete(
      desktop: CreateBrandContent(brand: brand),
    );
  }
}
