import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_state.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/device/device_utility.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/cubit/brand_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/category/presentation/cubit/category_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/models/product_model.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/cubit/product_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_form_buttons.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_desktop_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/widgets/product_mobile_layout.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/widgets/media_image_picker.dart';

class CreateProductContent extends StatefulWidget {
  const CreateProductContent({super.key, this.product});

  final ProductModel? product;

  @override
  State<CreateProductContent> createState() => _CreateProductContentState();
}

class _CreateProductContentState extends State<CreateProductContent> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  TProductType _productType = TProductType.single;
  late final TextEditingController _stockController;
  late final TextEditingController _priceController;
  late final TextEditingController _salePriceController;
  late final TextEditingController _attrNameController;
  late final TextEditingController _attrValuesController;
  late List<ProductAttributeModel> _attributes;
  late List<ProductVariationModel> _variations;
  String? _thumbnail;
  late List<String> _productImages;
  String _selectedBrand = '';
  BrandModel? _selectedBrandModel;
  late List<String> _selectedCategories;
  bool _isFeatured = true;



  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _titleController = TextEditingController(text: p?.title ?? '');
    _descriptionController = TextEditingController(text: p?.description ?? '');
    _productType = p?.productType ?? TProductType.single;
    _stockController =
        TextEditingController(text: p != null ? p.stock.toString() : '');
    _priceController = TextEditingController(
        text: p != null && p.price > 0 ? p.price.toString() : '');
    _salePriceController = TextEditingController(
        text: p != null && p.salePrice > 0 ? p.salePrice.toString() : '');
    _attrNameController = TextEditingController();
    _attrValuesController = TextEditingController();
    _attributes = p != null ? List.of(p.attributes) : [];
    _variations = p != null ? List.of(p.variations) : [];
    _thumbnail = p?.thumbnail;
    _productImages = p != null ? List.of(p.images) : [];
    _selectedBrand = p?.brand ?? '';
    _selectedBrandModel = p?.brandData ??
        (p != null && p.brand.isNotEmpty
            ? BrandModel(
                id: '',
                name: p.brand,
                image: p.brandImage,
                categories: const [],
                productsCount: 0,
                isFeatured: false,
              )
            : null);
    _selectedCategories = p != null ? List.of(p.categories) : [];
    _isFeatured = p?.isFeatured ?? false;

    // Fetch categories and brands from Firestore
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryCubit>().fetchCategories();
      context.read<BrandCubit>().fetchBrands();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _salePriceController.dispose();
    _attrNameController.dispose();
    _attrValuesController.dispose();
    super.dispose();
  }

  void _addAttribute() {
    final name = _attrNameController.text.trim();
    final values = _attrValuesController.text
        .split(',')
        .map((v) => v.trim())
        .where((v) => v.isNotEmpty)
        .toList();
    if (name.isEmpty || values.isEmpty) return;
    setState(() {
      _attributes.add(ProductAttributeModel(name: name, values: values));
      _attrNameController.clear();
      _attrValuesController.clear();
      _generateVariations();
    });
  }

  void _removeAttribute(int index) {
    setState(() {
      _attributes.removeAt(index);
      _generateVariations();
    });
  }

  void _generateVariations() {
    if (_attributes.isEmpty) {
      _variations = [];
      return;
    }
    List<Map<String, String>> combos = [{}];
    for (final attr in _attributes) {
      final newCombos = <Map<String, String>>[];
      for (final combo in combos) {
        for (final value in attr.values) {
          newCombos.add({...combo, attr.name: value});
        }
      }
      combos = newCombos;
    }
    _variations = combos
        .asMap()
        .entries
        .map((e) => ProductVariationModel(id: 'v${e.key}', attributes: e.value))
        .toList();
  }

  void _removeVariations() => setState(() => _variations = []);

  Future<void> _pickThumbnail() async {
    final url = await MediaImagePicker.showSingle(context: context);
    if (url != null) setState(() => _thumbnail = url);
  }

  Future<void> _pickAdditionalImages() async {
    final url = await MediaImagePicker.show(context: context);
    if (url != null) setState(() => _productImages = url);
  }

  void _updateVariationImage(int index, String image) {
    setState(() {
      final old = _variations[index];
      _variations[index] = ProductVariationModel(
        id: old.id,
        attributes: old.attributes,
        price: old.price,
        salePrice: old.salePrice,
        stock: old.stock,
        image: image,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = TDeviceUtils.isDesktopScreen(context);
    final heading = _isEditing ? 'Edit Product' : 'Create Product';

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TBreadcrumbsWithHeading(
                  heading: heading,
                  breadcrumbItems: [AppRoutes.products, heading],
                  returnToPreviousScreen: true,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                if (isDesktop)
                  ProductDesktopLayout(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    productType: _productType,
                    stockController: _stockController,
                    priceController: _priceController,
                    salePriceController: _salePriceController,
                    attrNameController: _attrNameController,
                    attrValuesController: _attrValuesController,
                    attributes: _attributes,
                    variations: _variations,
                    thumbnail: _thumbnail,
                    productImages: _productImages,
                    selectedBrand: _selectedBrand,
                    selectedCategories: _selectedCategories,
                    isFeatured: _isFeatured,
                    onProductTypeChanged: (type) =>
                        setState(() => _productType = type),
                    onAddAttribute: _addAttribute,
                    onRemoveAttribute: _removeAttribute,
                    onRemoveVariations: _removeVariations,
                    onPickThumbnail: _pickThumbnail,
                    onPickImages: _pickAdditionalImages,
                    onRemoveImage: (img) =>
                        setState(() => _productImages.remove(img)),
                    onBrandChanged: (brand) => setState(() {
                      _selectedBrand = brand?.name ?? '';
                      _selectedBrandModel = brand;
                    }),
                    onCategorySelected: (v) {
                      if (v != null && !_selectedCategories.contains(v)) {
                        setState(() => _selectedCategories.add(v));
                      }
                    },
                    onCategoryRemoved: (v) =>
                        setState(() => _selectedCategories.remove(v)),
                    onVisibilityChanged: (v) =>
                        setState(() => _isFeatured = v),
                    onVariationImageChanged: _updateVariationImage,
                  )
                else
                  ProductMobileLayout(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    productType: _productType,
                    stockController: _stockController,
                    priceController: _priceController,
                    salePriceController: _salePriceController,
                    attrNameController: _attrNameController,
                    attrValuesController: _attrValuesController,
                    attributes: _attributes,
                    variations: _variations,
                    thumbnail: _thumbnail,
                    productImages: _productImages,
                    selectedBrand: _selectedBrand,
                    selectedCategories: _selectedCategories,
                    isFeatured: _isFeatured,
                    onProductTypeChanged: (type) =>
                        setState(() => _productType = type),
                    onAddAttribute: _addAttribute,
                    onRemoveAttribute: _removeAttribute,
                    onRemoveVariations: _removeVariations,
                    onPickThumbnail: _pickThumbnail,
                    onPickImages: _pickAdditionalImages,
                    onRemoveImage: (img) =>
                        setState(() => _productImages.remove(img)),
                    onBrandChanged: (brand) => setState(() {
                      _selectedBrand = brand?.name ?? '';
                      _selectedBrandModel = brand;
                    }),
                    onCategorySelected: (v) {
                      if (v != null && !_selectedCategories.contains(v)) {
                        setState(() => _selectedCategories.add(v));
                      }
                    },
                    onCategoryRemoved: (v) =>
                        setState(() => _selectedCategories.remove(v)),
                    onVisibilityChanged: (v) =>
                        setState(() => _isFeatured = v),
                    onVariationImageChanged: _updateVariationImage,
                  ),
                const SizedBox(height: TSizes.spaceBtwSections),
                ProductFormButtons(
                  isEditing: _isEditing,
                  onDiscard: () => Navigator.pop(context),
                  onSave: () async {
                    if (_formKey.currentState!.validate()) {
                      final product = ProductModel(
                        id: _isEditing
                            ? widget.product!.id
                            : DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        thumbnail: _thumbnail ?? '',
                        images: _productImages,
                        productType: _productType,
                        stock: int.tryParse(_stockController.text.trim()) ?? 0,
                        price:
                            double.tryParse(_priceController.text.trim()) ?? 0,
                        salePrice: double.tryParse(
                                _salePriceController.text.trim()) ??
                            0,
                        sku: _isEditing ? widget.product!.sku : '',
                        categoryId: _selectedCategories.isNotEmpty
                            ? _selectedCategories.first
                            : '',
                        brand: _selectedBrand,
                        brandImage: _selectedBrandModel?.image ?? '',
                        brandData: _selectedBrandModel,
                        categories: _selectedCategories,
                        isFeatured: _isFeatured,
                        attributes: _attributes,
                        variations: _variations,
                        createdAt: _isEditing
                            ? widget.product!.createdAt
                            : DateTime.now(),
                        updatedAt: DateTime.now(),
                      );

                      if (_isEditing) {
                        await context.read<ProductCubit>().updateProduct(product);
                      } else {
                        await context.read<ProductCubit>().createProduct(product);
                      }

                      if (!mounted) return;
                      if (context.read<ProductCubit>().state.status ==
                          ApiStatus.success) {
                        Navigator.pop(context, true);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
