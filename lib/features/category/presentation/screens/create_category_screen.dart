import 'package:flutter/material.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/responsive/site_templete.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/presentation/widgets/create_category_content.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key, this.category});

  /// Pass a [CategoryModel] to enter edit mode.
  final CategoryModel? category;

  @override
  Widget build(BuildContext context) {
    return SiteTemplete(
      desktop: CreateCategoryContent(category: category),
    );
  }
}
