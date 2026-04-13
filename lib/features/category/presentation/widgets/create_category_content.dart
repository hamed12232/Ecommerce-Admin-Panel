import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/images/image_uploader.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/colors.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/enums.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/models/category_model.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_image_picker.dart';

class CreateCategoryContent extends StatefulWidget {
  const CreateCategoryContent({super.key, this.category});

  /// If non-null, we are in "edit" mode.
  final CategoryModel? category;

  @override
  State<CreateCategoryContent> createState() => _CreateCategoryContentState();
}

class _CreateCategoryContentState extends State<CreateCategoryContent> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  String _selectedParent = '';
  bool _isFeatured = false;
  String? _imageUrl;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    final cat = widget.category;
    _nameController = TextEditingController(text: cat?.name ?? '');
    _selectedParent = cat?.parentCategory ?? '';
    _isFeatured = cat?.isFeatured ?? false;
    _imageUrl = cat?.image;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);
    final heading = _isEditing ? 'Update Category' : 'Create Category';
    final breadcrumb = _isEditing ? 'Update Category' : 'Create Category';

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
                breadcrumbItems: [AppRoutes.categories, breadcrumb],
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

                        // ── Category Name ────────────
                        TextFormField(
                          controller: _nameController,
                          validator: (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Category name is required'
                                  : null,
                          decoration: const InputDecoration(
                            labelText: 'Category Name',
                            prefixIcon: Icon(Iconsax.category),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),

                        // ── Parent Category ──────────
                        DropdownButtonFormField<String>(
                          initialValue: _selectedParent,
                          decoration: const InputDecoration(
                            labelText: 'Parent Category',
                            prefixIcon: Icon(Iconsax.bezier),
                          ),
                          items: CategoryModel.parentCategoryNames
                              .map((name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(name.isEmpty
                                        ? 'None'
                                        : name),
                                  ))
                              .toList(),
                          onChanged: (value) => setState(
                              () => _selectedParent = value ?? ''),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // ── Image Uploader ───────────
                        TImageUploader(
                          image: _imageUrl,
                          imageType: _imageUrl != null &&
                                  _imageUrl!.startsWith('http')
                              ? ImageType.network
                              : ImageType.asset,
                          onIconButtonPressed: () async {
                            final url =
                                await MediaImagePicker.showSingle(
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
                          controlAffinity:
                              ListTileControlAffinity.leading,
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
                                // TODO: Implement create/update logic
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
