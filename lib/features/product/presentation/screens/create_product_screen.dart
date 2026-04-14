import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/create_product_content.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key, this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return SiteTemplete(
      desktop: CreateProductContent(product: product),
    );
  }
}
