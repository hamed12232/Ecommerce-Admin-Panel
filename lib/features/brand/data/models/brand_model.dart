import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class BrandModel implements BaseEntity {
  @override
  final String id;
  final String name;
  final String image;
  final bool isFeatured;
  final List<String> categories;
  final int productsCount;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  const BrandModel({
    required this.id,
    required this.name,
    this.image = '',
    this.isFeatured = false,
    this.categories = const [],
    this.productsCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate =>
      createdAt != null ? THelperFunctions.getFormattedDate(createdAt!) : '';

  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isFeatured,
    List<String>? categories,
    int? productsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      categories: categories ?? this.categories,
      productsCount: productsCount ?? this.productsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'Categories': categories,
      'ProductsCount': productsCount,
      
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
      categories: (json['Categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      productsCount: json['ProductsCount'] as int? ?? 0,
    
    );
  }

  @Deprecated('Use BrandCubit to fetch brands')
  static List<BrandModel> get dummyBrands => [];
}
