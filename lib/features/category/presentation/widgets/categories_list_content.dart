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
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/presentation/cubit/category_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/category/presentation/table/category_table_source.dart';

class CategoriesListContent extends StatefulWidget {
  const CategoriesListContent({super.key});

  @override
  State<CategoriesListContent> createState() => _CategoriesListContentState();
}

class _CategoriesListContentState extends State<CategoriesListContent> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  List<CategoryModel> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories(String query, List<CategoryModel> categories) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = categories;
      } else {
        _filteredCategories = categories
            .where((c) =>
                c.name.toLowerCase().contains(query.toLowerCase()) ||
                c.parentCategory.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoryCubit, ApiState<List<CategoryModel>>>(
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
                  Text(state.error ?? 'Error loading categories'),
                  const SizedBox(height: TSizes.md),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<CategoryCubit>().fetchCategories(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final categories = state.data ?? [];
          if (_searchQuery.isEmpty && _filteredCategories.isEmpty) {
            _filteredCategories = categories;
          } else if (_searchQuery.isEmpty) {
            _filteredCategories = categories;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBreadcrumbsWithHeading(
                    heading: 'Categories',
                    breadcrumbItems: [AppRoutes.categories],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  _buildActionRow(context),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TRoundedContainer(
                    child: categories.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(TSizes.xl),
                              child: Text('No categories found'),
                            ),
                          )
                        : TPaginatedDataTable(
                            minWidth: 700,
                            tableHeight: 760,
                            sortColumnIndex: 0,
                            columns: const [
                              DataColumn2(
                                  label: Text('Category'), size: ColumnSize.L),
                              DataColumn2(label: Text('Parent Category')),
                              DataColumn2(
                                  label: Text('Featured'), fixedWidth: 100),
                              DataColumn2(label: Text('Date')),
                              DataColumn2(
                                  label: Text('Action'), fixedWidth: 120),
                            ],
                            source: CategoryRows(context, _filteredCategories),
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
      width: 220,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createCategory),
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
    final state = context.read<CategoryCubit>().state;
    final categories = state.data ?? [];

    return TextFormField(
      controller: _searchController,
      onChanged: (query) => _filterCategories(query, categories),
      decoration: InputDecoration(
        hintText: 'Search Categories',
        prefixIcon: const Icon(Iconsax.search_normal),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _filterCategories('', categories);
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
