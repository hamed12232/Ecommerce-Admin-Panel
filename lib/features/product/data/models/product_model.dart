import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/models/brand_model.dart';

class ProductAttributeModel {
  final String name;
  final List<String> values;

  const ProductAttributeModel({required this.name, required this.values});

  Map<String, dynamic> toJson() => {'name': name, 'values': values};

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) {
    return ProductAttributeModel(
      name: json['name'] as String? ?? '',
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}

class ProductVariationModel {
  final String id;
  final String sku;
  final String description;
  final Map<String, String> attributes;
  final double price;
  final double salePrice;
  final int stock;
  final String image;

  const ProductVariationModel({
    required this.id,
    this.sku = '',
    this.description = '',
    required this.attributes,
    this.price = 0,
    this.salePrice = 0,
    this.stock = 0,
    this.image = '',
  });

  String get attributeSummary =>
      attributes.entries.map((e) => '${e.key}: ${e.value}').join(', ');

  Map<String, dynamic> toJson() => {
        'id': id,
        'sku': sku,
        'description': description,
        'attributeValues': attributes,
        'price': price,
        'salePrice': salePrice,
        'stock': stock,
        'image': image,
      };

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      description: json['description'] as String? ?? '',
      attributes: (json['attributeValues'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v.toString())) ??
          {},
      price: (json['price'] as num?)?.toDouble() ?? 0,
      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] as int? ?? 0,
      image: json['image'] as String? ?? '',
    );
  }
}

enum TProductType { single, variable }

class ProductModel implements BaseEntity {
  @override
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final List<String> images;
  final TProductType productType;
  final int stock;
  final double price;
  final double salePrice;
  final String sku;
  final String categoryId;
  final String brand;
  final String brandImage;
  final BrandModel? brandData;
  final List<String> categories;
  final bool isFeatured;
  final List<ProductAttributeModel> attributes;
  final List<ProductVariationModel> variations;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.title,
    this.description = '',
    this.thumbnail = '',
    this.images = const [],
    this.productType = TProductType.single,
    this.stock = 0,
    this.price = 0,
    this.salePrice = 0,
    this.sku = '',
    this.categoryId = '',
    this.brand = '',
    this.brandImage = '',
    this.brandData,
    this.categories = const [],
    this.isFeatured = false,
    this.attributes = const [],
    this.variations = const [],
    required this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => THelperFunctions.getFormattedDate(createdAt);

  String get priceDisplay {
    if (productType == TProductType.variable && variations.isNotEmpty) {
      final prices = variations.map((v) => v.price).toList()..sort();
      final salePrices =
          variations.map((v) => v.salePrice).where((p) => p > 0).toList();
      if (salePrices.isNotEmpty) {
        salePrices.sort();
        return '\$${salePrices.first} - \$${prices.last}';
      }
      return '\$${prices.first} - \$${prices.last}';
    }
    if (salePrice > 0) return '\$${salePrice.toStringAsFixed(0)}';
    return '\$${price.toStringAsFixed(0)}';
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnail,
    List<String>? images,
    TProductType? productType,
    int? stock,
    double? price,
    double? salePrice,
    String? sku,
    String? categoryId,
    String? brand,
    String? brandImage,
    BrandModel? brandData,
    List<String>? categories,
    bool? isFeatured,
    List<ProductAttributeModel>? attributes,
    List<ProductVariationModel>? variations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      productType: productType ?? this.productType,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      sku: sku ?? this.sku,
      categoryId: categoryId ?? this.categoryId,
      brand: brand ?? this.brand,
      brandImage: brandImage ?? this.brandImage,
      brandData: brandData ?? this.brandData,
      categories: categories ?? this.categories,
      isFeatured: isFeatured ?? this.isFeatured,
      attributes: attributes ?? this.attributes,
      variations: variations ?? this.variations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    final brandMap = brandData?.toJson() ??
        {
          'Id': '',
          'Image': brandImage,
          'IsFeatured': false,
          'Name': brand,
          'ProductsCount': 0,
          'Categories': categories,
        };

    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'images': images,
      'productType': productType.name,
      'stock': stock,
      'price': price,
      'salePrice': salePrice,
      'sku': sku,
      'categoryId': categoryId,
      'brand': brandMap,
      'categories': categories,
      'isFeatured': isFeatured,
      'productAttributes': attributes.map((a) => a.toJson()).toList(),
      'productVariations': variations.map((v) => v.toJson()).toList(),
      'date': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productType: (json['productType'] == 'ProductType.variable' || json['productType'] == 'variable')
          ? TProductType.variable
          : TProductType.single,
      stock: json['stock'] as int? ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0,
      sku: json['sku'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      brandData: json['brand'] != null && json['brand'] is Map
          ? BrandModel.fromJson(Map<String, dynamic>.from(json['brand'] as Map))
          : null,
      brand: (json['brand'] != null && json['brand'] is Map)
          ? (json['brand']['Name'] as String? ?? '')
          : (json['brand'] as String? ?? ''),
      brandImage: (json['brand'] != null && json['brand'] is Map)
          ? (json['brand']['Image'] as String? ?? '')
          : (json['brandImage'] as String? ?? ''),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isFeatured: json['isFeatured'] as bool? ?? false,
      attributes: (json['productAttributes'] as List<dynamic>?)
              ?.map((e) =>
                  ProductAttributeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          ((json['attributes'] as List<dynamic>?)?.map((e) => ProductAttributeModel.fromJson(e as Map<String, dynamic>)).toList() ?? []),
      variations: (json['productVariations'] as List<dynamic>?)
              ?.map((e) =>
                  ProductVariationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          ((json['variations'] as List<dynamic>?)?.map((e) => ProductVariationModel.fromJson(e as Map<String, dynamic>)).toList() ?? []),
      createdAt: json['date'] != null
          ? (json['date'] is int
              ? DateTime.fromMillisecondsSinceEpoch(json['date'])
              : DateTime.tryParse(json['date']) ?? DateTime.now())
          : (json['createdAt'] != null ? (json['createdAt'] is int ? DateTime.fromMillisecondsSinceEpoch(json['createdAt']) : DateTime.parse(json['createdAt'])) : DateTime.now()),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'])
              : DateTime.tryParse(json['updatedAt']))
          : null,
    );
  }

  @Deprecated('Use ProductCubit to fetch products')
  static List<ProductModel> get dummyProducts => [];
}
