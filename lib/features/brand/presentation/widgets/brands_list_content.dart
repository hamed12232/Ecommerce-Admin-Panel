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
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/table/brand_table_source.dart';

class BrandsListContent extends StatefulWidget {
  const BrandsListContent({super.key});

  @override
  State<BrandsListContent> createState() => _BrandsListContentState();
}

class _BrandsListContentState extends State<BrandsListContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  late List<BrandModel> _filteredBrands;

  @override
  void initState() {
    super.initState();
    _filteredBrands = BrandModel.dummyBrands;
  }

  void _filterBrands(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredBrands = BrandModel.dummyBrands;
      } else {
        _filteredBrands = BrandModel.dummyBrands
            .where((b) =>
                b.name.toLowerCase().contains(query.toLowerCase()) ||
                b.categories.any((c) => c.toLowerCase().contains(query.toLowerCase())))
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
                heading: 'Brands',
                breadcrumbItems: [AppRoutes.brands],
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
                    DataColumn2(label: Text('Brand'), size: ColumnSize.L),
                    DataColumn2(label: Text('Categories'), size: ColumnSize.L),
                    DataColumn2(label: Text('Featured'), fixedWidth: 100),
                    DataColumn2(label: Text('Date')),
                    DataColumn2(label: Text('Action'), fixedWidth: 120),
                  ],
                  source: BrandRows(context, _filteredBrands),
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
      width: 200,
      child: ElevatedButton.icon(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.createBrand),
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

  Widget _buildSearchField() {
    return TextFormField(
      controller: _searchController,
      onChanged: _filterBrands,
      decoration: InputDecoration(
        hintText: 'Search Brands',
        prefixIcon: const Icon(Iconsax.search_normal),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _filterBrands('');
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
