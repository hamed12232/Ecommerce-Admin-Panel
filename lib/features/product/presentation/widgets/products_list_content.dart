import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/table/product_table_source.dart';

class ProductsListContent extends StatefulWidget {
  const ProductsListContent({super.key});

  @override
  State<ProductsListContent> createState() => _ProductsListContentState();
}

class _ProductsListContentState extends State<ProductsListContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late List<ProductModel> _filteredProducts;
  late ProductRows _dataSource;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.of(ProductModel.dummyProducts);
    _dataSource = ProductRows(context, _filteredProducts);
  }

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredProducts = List.of(ProductModel.dummyProducts);
      } else {
        _filteredProducts = ProductModel.dummyProducts
            .where((p) =>
                p.title.toLowerCase().contains(query.toLowerCase()) ||
                p.brand.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      _dataSource = ProductRows(context, _filteredProducts);
    });
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _dataSource.sort(columnIndex, ascending);
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
              // ── Breadcrumb ────────────────────────────────
              const TBreadcrumbsWithHeading(
                heading: 'Products',
                breadcrumbItems: [AppRoutes.products],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Action Row ────────────────────────────────
              _buildActionRow(context),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Data Table ───────────────────────────────
              TPaginatedDataTable(
                minWidth: 900,
                tableHeight: 760,
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: [
                  DataColumn2(
                    label: const Text('Product'),
                    size: ColumnSize.L,
                    onSort: _onSort,
                  ),
                  DataColumn2(
                    label: const Text('Stock'),
                    onSort: _onSort,
                  ),
                  const DataColumn2(
                    label: Text('Brand'),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: const Text('Price'),
                    fixedWidth: 140,
                    onSort: _onSort,
                  ),
                  const DataColumn2(
                    label: Text('Date'),
                    fixedWidth: 160,
                  ),
                  const DataColumn2(
                    label: Text('Action'),
                    fixedWidth: 100,
                  ),
                ],
                source: _dataSource,
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
      width: 200,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createProduct),
        icon: const Icon(Iconsax.add, size: 20),
        label: const Text('Add Product'),
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
      onChanged: _filterProducts,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Iconsax.search_normal),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _filterProducts('');
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
