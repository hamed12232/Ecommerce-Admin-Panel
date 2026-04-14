import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/t_rounded_image.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_image_picker.dart';

class CreateBannerContent extends StatefulWidget {
  const CreateBannerContent({super.key, this.banner});

  /// Pass a [BannerModel] to enter edit mode.
  final BannerModel? banner;

  @override
  State<CreateBannerContent> createState() => _CreateBannerContentState();
}

class _CreateBannerContentState extends State<CreateBannerContent> {
  bool _isActive = false;
  String _targetScreen = BannerModel.availableRoutes.first;
  String? _imageUrl;

  bool get _isEditing => widget.banner != null;

  @override
  void initState() {
    super.initState();
    final banner = widget.banner;
    _isActive = banner?.isActive ?? false;
    _targetScreen = banner?.targetScreen.isNotEmpty == true
        ? banner!.targetScreen
        : BannerModel.availableRoutes.first;
    _imageUrl = banner?.image;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);
    final heading = _isEditing ? 'Update Banner' : 'Create Banner';
    final breadcrumb = _isEditing ? 'Update Banner' : 'Create Banner';

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Breadcrumb ───────────────────────────
              TBreadcrumbsWithHeading(
                heading: heading,
                breadcrumbItems: [AppRoutes.banners, breadcrumb],
                returnToPreviousScreen: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Form Card ────────────────────────────
              SizedBox(
                width: isDesktop
                    ? MediaQuery.of(context).size.width * 0.5
                    : double.infinity,
                child: TRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Heading ──────────────────
                      Text(
                        heading,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // ── Banner Image Area ─────────
                      _buildBannerImagePicker(context),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // ── Active Toggle ──────────────
                      Text(
                        'Make your Banner Active or InActive',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      CheckboxListTile(
                        value: _isActive,
                        onChanged: (value) =>
                            setState(() => _isActive = value ?? false),
                        title: const Text('Active'),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        activeColor: TColors.primary,
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),

                      // ── Target Screen Dropdown ────
                      DropdownButtonFormField<String>(
                        initialValue: _targetScreen,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.routing),
                        ),
                        items: BannerModel.availableRoutes
                            .map((route) => DropdownMenuItem(
                                  value: route,
                                  child: Text(route),
                                ))
                            .toList(),
                        onChanged: (value) => setState(
                            () => _targetScreen = value ?? _targetScreen),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // ── Submit Button ────────────
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement create/update logic
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primary,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: TSizes.md),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(TSizes.borderRadiusMd),
                            ),
                          ),
                          child: Text(_isEditing ? 'Update' : 'Create'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerImagePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Image Preview Box ─────────────────────────
        ClipRRect(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: TColors.primaryBackground,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
              border: Border.all(color: TColors.grey.withOpacity(0.5)),
            ),
            child: _imageUrl != null && _imageUrl!.isNotEmpty
                ? TRoundedImage(
                    image: _imageUrl,
                    width: double.infinity,
                    height: 200,
                    padding: 0,
                    fit: BoxFit.cover,
                    borderRadius: TSizes.borderRadiusMd,
                    imageType: _imageUrl!.startsWith('http')
                        ? ImageType.network
                        : ImageType.asset,
                  )
                : const Center(
                    child: Icon(
                      Iconsax.image,
                      size: 80,
                      color: TColors.darkGrey,
                    ),
                  ),
          ),
        ),

        // ── Select Image Text Button ──────────────────
        const SizedBox(height: TSizes.sm),
        Center(
          child: TextButton(
            onPressed: () async {
              final url = await MediaImagePicker.showSingle(context: context);
              if (url != null) {
                setState(() => _imageUrl = url);
              }
            },
            child: const Text(
              'Select Image',
              style: TextStyle(
                color: TColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
      
    );
  }
}
