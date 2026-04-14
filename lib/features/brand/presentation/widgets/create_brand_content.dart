import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/chips/rounded_choice_chips.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_image_picker.dart';

class CreateBrandContent extends StatefulWidget {
  const CreateBrandContent({super.key, this.brand});

  /// If non-null, we are in "edit" mode.
  final BrandModel? brand;

  @override
  State<CreateBrandContent> createState() => _CreateBrandContentState();
}

class _CreateBrandContentState extends State<CreateBrandContent> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  final Set<String> _selectedCategories = {};
  bool _isFeatured = false;
  String? _imageUrl;

  bool get _isEditing => widget.brand != null;

  @override
  void initState() {
    super.initState();
    final brand = widget.brand;
    _nameController = TextEditingController(text: brand?.name ?? '');
    if (brand != null) {
      _selectedCategories.addAll(brand.categories);
    }
    _isFeatured = brand?.isFeatured ?? false;
    _imageUrl = brand?.image;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);
    final heading = _isEditing ? 'Update Brand' : 'Create Brand';
    final breadcrumb = _isEditing ? 'Update Brand' : 'Create Brand';

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
                breadcrumbItems: [AppRoutes.brands, breadcrumb],
                returnToPreviousScreen: true,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // ── Form Card ────────────────────────────
              SizedBox(
                width: isDesktop
                    ? MediaQuery.of(context).size.width * 0.5
                    : double.infinity,
                child: TRoundedContainer(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          heading,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // ── Brand Name ────────────
                        TextFormField(
                          controller: _nameController,
                          validator: (value) => (value == null || value.isEmpty)
                              ? 'Brand name is required'
                              : null,
                          decoration: const InputDecoration(
                            labelText: 'Brand Name',
                            prefixIcon: Icon(Iconsax.box),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

// ── Select Categories ──────────
                        Text(
                          'Select Categories',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Wrap(
                          spacing: TSizes.sm,
                          runSpacing: TSizes.sm,
                          children: CategoryModel.dummyCategories
                              .map((c) => c.name)
                              .map((name) {
                            final isSelected =
                                _selectedCategories.contains(name);
                            return TChoiceChip(
                              text: name,
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedCategories.add(name);
                                  } else {
                                    _selectedCategories.remove(name);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // ── Image Uploader ───────────
                        TImageUploader(
                          image: _imageUrl,
                          imageType:
                              _imageUrl != null && _imageUrl!.startsWith('http')
                                  ? ImageType.network
                                  : ImageType.asset,
                          onIconButtonPressed: () async {
                            final url = await MediaImagePicker.showSingle(
                                context: context);
                            if (url != null) {
                              setState(() => _imageUrl = url);
                            }
                          },
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),

                        // ── Featured Checkbox ────────
                        CheckboxListTile(
                          value: _isFeatured,
                          onChanged: (value) =>
                              setState(() => _isFeatured = value ?? false),
                          title: const Text('Featured'),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          activeColor: TColors.primary,
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // ── Submit Button ────────────
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: TSizes.md),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    TSizes.borderRadiusMd),
                              ),
                            ),
                            child: Text(_isEditing ? 'Update' : 'Create'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
