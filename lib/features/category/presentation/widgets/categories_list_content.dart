import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/presentation/table/category_table_source.dart';

class CategoriesListContent extends StatefulWidget {
  const CategoriesListContent({super.key});

  @override
  State<CategoriesListContent> createState() => _CategoriesListContentState();
}

class _CategoriesListContentState extends State<CategoriesListContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  late List<CategoryModel> _filteredCategories;

  @override
  void initState() {
    super.initState();
    _filteredCategories = CategoryModel.dummyCategories;
  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = CategoryModel.dummyCategories;
      } else {
        _filteredCategories = CategoryModel.dummyCategories
            .where((c) =>
                c.name.toLowerCase().contains(query.toLowerCase()) ||
                c.parentCategory.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Breadcrumb ───────────────────────────────
              const TBreadcrumbsWithHeading(
                heading: 'Categories',
                breadcrumbItems: [AppRoutes.categories],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Action Row: Create Button + Search ───────
              _buildActionRow(context),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Data Table ───────────────────────────────
              TRoundedContainer(
                child: TPaginatedDataTable(
                  minWidth: 700,
                  tableHeight: 760,
                  sortColumnIndex: 0,
                  columns: const [
                    DataColumn2(label: Text('Category'), size: ColumnSize.L),
                    DataColumn2(label: Text('Parent Category')),
                    DataColumn2(label: Text('Featured'), fixedWidth: 100),
                    DataColumn2(label: Text('Date')),
                    DataColumn2(label: Text('Action'), fixedWidth: 120),
                  ],
                  source: CategoryRows(context, _filteredCategories),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);

    if (isDesktop) {
      return Row(
        children: [
          _buildCreateButton(),
          const Spacer(),
          SizedBox(width: 400, child: _buildSearchField()),
        ],
      );
    }

    // Mobile / Tablet: stack vertically
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCreateButton(),
        const SizedBox(height: TSizes.spaceBtwItems),
        _buildSearchField(),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: 220,
      child: ElevatedButton.icon(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.createCategory),
        icon: const Icon(Iconsax.add, size: 20),
        label: const Text('Create New Category'),
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: TSizes.md, vertical: TSizes.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextFormField(
      controller: _searchController,
      onChanged: _filterCategories,
      decoration: InputDecoration(
        hintText: 'Search Categories',
        prefixIcon: const Icon(Iconsax.search_normal),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _filterCategories('');
                },
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(TSizes.borderRadiusMd)),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: TSizes.md, vertical: TSizes.sm),
      ),
    );
  }
}
