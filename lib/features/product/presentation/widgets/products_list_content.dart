import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_state.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/cubit/product_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/table/product_table_source.dart';

class ProductsListContent extends StatefulWidget {
  const ProductsListContent({super.key});

  @override
  State<ProductsListContent> createState() => _ProductsListContentState();
}

class _ProductsListContentState extends State<ProductsListContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  List<ProductModel> _filteredProducts = [];
  ProductRows? _dataSource;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

  void _filterProducts(String query, List<ProductModel> products) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredProducts = products;
      } else {
        _filteredProducts = products
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
      _dataSource?.sort(columnIndex, ascending);
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
      body: BlocBuilder<ProductCubit, ApiState<List<ProductModel>>>(
        builder: (context, state) {
          if (state.status == ApiStatus.loading ||
              state.status == ApiStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ApiStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error ?? 'Error loading products'),
                  const SizedBox(height: TSizes.md),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProductCubit>().fetchProducts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final products = state.data ?? [];
          if (_searchQuery.isEmpty) {
            _filteredProducts = products;
          } else {
            _filteredProducts = products
                .where((p) =>
                    p.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    p.brand.toLowerCase().contains(_searchQuery.toLowerCase()))
                .toList();
          }
          _dataSource = ProductRows(context, _filteredProducts);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBreadcrumbsWithHeading(
                    heading: 'Products',
                    breadcrumbItems: [AppRoutes.products],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  _buildActionRow(context, products),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  products.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(TSizes.xl),
                            child: Text('No products found'),
                          ),
                        )
                      : TPaginatedDataTable(
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
                          source: _dataSource ??
                              ProductRows(context, _filteredProducts),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionRow(BuildContext context, List<ProductModel> products) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);

    if (isDesktop) {
      return Row(
        children: [
          _buildCreateButton(),
          const Spacer(),
          SizedBox(width: 400, child: _buildSearchField(products)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCreateButton(),
        const SizedBox(height: TSizes.spaceBtwItems),
        _buildSearchField(products),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, AppRoutes.createProduct);
          if (result == true && mounted) {
            context.read<ProductCubit>().fetchProducts();
          }
        },
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

  Widget _buildSearchField(List<ProductModel> products) {
    return TextFormField(
      controller: _searchController,
      onChanged: (query) => _filterProducts(query, products),
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Iconsax.search_normal),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _filterProducts('', products);
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
