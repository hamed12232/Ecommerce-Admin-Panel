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
import 'package:yt_ecommerce_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/presentation/table/banner_table_source.dart';

class BannersListContent extends StatefulWidget {
  const BannersListContent({super.key});

  @override
  State<BannersListContent> createState() => _BannersListContentState();
}

class _BannersListContentState extends State<BannersListContent> {
  late List<BannerModel> _banners;

  @override
  void initState() {
    super.initState();
    _banners = BannerModel.dummyBanners;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Breadcrumb ───────────────────────────────
              const TBreadcrumbsWithHeading(
                heading: 'Banners',
                breadcrumbItems: [AppRoutes.banners],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Action Row ───────────────────────────────
              _buildActionRow(context, isDesktop),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Data Table ───────────────────────────────
              TRoundedContainer(
                child: TPaginatedDataTable(
                  minWidth: 600,
                  tableHeight: 700,
                  sortColumnIndex: 0,
                  columns: const [
                    DataColumn2(label: Text('Banner'), size: ColumnSize.L),
                    DataColumn2(label: Text('Redirect Screen'), size: ColumnSize.M),
                    DataColumn2(label: Text('Active'), fixedWidth: 100),
                    DataColumn2(label: Text('Action'), fixedWidth: 120),
                  ],
                  source: BannerRows(context, _banners),
                ),
              ),
            ],
          ),
        ),
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
        onPressed: () => Navigator.pushNamed(context, AppRoutes.createBanner),
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
