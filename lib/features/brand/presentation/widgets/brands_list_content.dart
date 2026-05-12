import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/data_table/paginated_data_table.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_state.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/cubit/brand_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/table/brand_table_source.dart';

class BrandsListContent extends StatefulWidget {
  const BrandsListContent({super.key});

  @override
  State<BrandsListContent> createState() => _BrandsListContentState();
}

class _BrandsListContentState extends State<BrandsListContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  List<BrandModel> _filteredBrands = [];

  @override
  void initState() {
    super.initState();
    context.read<BrandCubit>().fetchBrands();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterBrands(String query, List<BrandModel> brands) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredBrands = brands;
      } else {
        _filteredBrands = brands
            .where((b) =>
                b.name.toLowerCase().contains(query.toLowerCase()) ||
                b.categories
                    .any((c) => c.toLowerCase().contains(query.toLowerCase())))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BrandCubit, ApiState<List<BrandModel>>>(
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
                  Text(state.error ?? 'Error loading brands'),
                  const SizedBox(height: TSizes.md),
                  ElevatedButton(
                    onPressed: () => context.read<BrandCubit>().fetchBrands(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final brands = state.data ?? [];
          if (_searchQuery.isEmpty) {
            _filteredBrands = brands;
          } else {
            _filteredBrands = brands
                .where((b) =>
                    b.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    b.categories.any((c) =>
                        c.toLowerCase().contains(_searchQuery.toLowerCase())))
                .toList();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBreadcrumbsWithHeading(
                    heading: 'Brands',
                    breadcrumbItems: [AppRoutes.brands],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  _buildActionRow(context, brands),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TRoundedContainer(
                    child: brands.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(TSizes.xl),
                              child: Text('No brands found'),
                            ),
                          )
                        : TPaginatedDataTable(
                            minWidth: 700,
                            tableHeight: 760,
                            sortColumnIndex: 0,
                            columns: const [
                              DataColumn2(
                                  label: Text('Brand'), size: ColumnSize.L),
                              DataColumn2(
                                  label: Text('Categories'),
                                  size: ColumnSize.L),
                              DataColumn2(
                                  label: Text('Featured'), fixedWidth: 100),
                              DataColumn2(label: Text('Date')),
                              DataColumn2(
                                  label: Text('Action'), fixedWidth: 120),
                            ],
                            source: BrandRows(context, _filteredBrands),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionRow(BuildContext context, List<BrandModel> brands) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);

    if (isDesktop) {
      return Row(
        children: [
          _buildCreateButton(),
          const Spacer(),
          SizedBox(width: 400, child: _buildSearchField(brands)),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCreateButton(),
        const SizedBox(height: TSizes.spaceBtwItems),
        _buildSearchField(brands),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, AppRoutes.createBrand);
          if (result == true && mounted) {
            context.read<BrandCubit>().fetchBrands();
          }
        },
        icon: const Icon(Iconsax.add, size: 20),
        label: const Text('Create New Brand'),
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

  Widget _buildSearchField(List<BrandModel> brands) {
    return TextFormField(
      controller: _searchController,
      onChanged: (query) => _filterBrands(query, brands),
      decoration: InputDecoration(
        hintText: 'Search Brands',
        prefixIcon: const Icon(Iconsax.search_normal),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _filterBrands('', brands);
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
