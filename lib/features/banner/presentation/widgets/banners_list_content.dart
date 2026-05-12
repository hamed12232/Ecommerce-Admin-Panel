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
import 'package:yt_ecommerce_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/presentation/cubit/banner_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/presentation/table/banner_table_source.dart';

class BannersListContent extends StatefulWidget {
  const BannersListContent({super.key});

  @override
  State<BannersListContent> createState() => _BannersListContentState();
}

class _BannersListContentState extends State<BannersListContent> {
  @override
  void initState() {
    super.initState();
    context.read<BannerCubit>().fetchBanners(activeOnly: false);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);

    return Scaffold(
      body: BlocBuilder<BannerCubit, ApiState<List<BannerModel>>>(
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
                  Text(state.error ?? 'Error loading banners'),
                  const SizedBox(height: TSizes.md),
                  ElevatedButton(
                    onPressed: () => context.read<BannerCubit>().fetchBanners(activeOnly: false),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final banners = state.data ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBreadcrumbsWithHeading(
                    heading: 'Banners',
                    breadcrumbItems: [AppRoutes.banners],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  _buildActionRow(context, isDesktop),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TRoundedContainer(
                    child: banners.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(TSizes.xl),
                              child: Text('No banners found'),
                            ),
                          )
                        : TPaginatedDataTable(
                            minWidth: 600,
                            tableHeight: 700,
                            sortColumnIndex: 0,
                            columns: const [
                              DataColumn2(
                                  label: Text('Banner'), size: ColumnSize.L),
                              DataColumn2(
                                  label: Text('Redirect Screen'),
                                  size: ColumnSize.M),
                              DataColumn2(
                                  label: Text('Active'), fixedWidth: 100),
                              DataColumn2(
                                  label: Text('Action'), fixedWidth: 120),
                            ],
                            source: BannerRows(context, banners),
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

  Widget _buildActionRow(BuildContext context, bool isDesktop) {
    final createButton = _buildCreateButton();

    if (isDesktop) {
      return Row(
        children: [createButton],
      );
    }

    return createButton;
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, AppRoutes.createBanner);
          if (result == true && mounted) {
            context.read<BannerCubit>().fetchBanners(activeOnly: false);
          }
        },
        icon: const Icon(Iconsax.add, size: 20),
        label: const Text('Create New Banner'),
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
}
