import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/products_list_content.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplete(
      desktop: ProductsListContent(),
    );
  }
}
