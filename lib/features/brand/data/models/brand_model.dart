import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class BrandModel implements BaseEntity {
  @override
  final String id;
  final String name;
  final String image;
  final bool isFeatured;
  final List<String> categories;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  const BrandModel({
    required this.id,
    required this.name,
    this.image = '',
    this.isFeatured = false,
    this.categories = const [],
    required this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => THelperFunctions.getFormattedDate(createdAt);

  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isFeatured,
    List<String>? categories,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'categories': categories,
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      isFeatured: json['isFeatured'] as bool? ?? false,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
              : DateTime.parse(json['createdAt']))
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is int
              ? DateTime.fromMillisecondsSinceEpoch(json['updatedAt'])
              : DateTime.tryParse(json['updatedAt']))
          : null,
    );
  }

  static List<BrandModel> dummyBrands = [
    BrandModel(
      id: '1',
      name: 'Nike',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      categories: ['Sports', 'Sports Equipments'],
      createdAt: DateTime(2024, 5, 20),
    ),
    BrandModel(
      id: '2',
      name: 'Acer',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      categories: ['Electronics', 'Laptop'],
      createdAt: DateTime(2024, 5, 18),
    ),
    BrandModel(
      id: '3',
      name: 'Adidas',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      categories: ['Sports', 'Clothes', 'Sport Shoes'],
      createdAt: DateTime(2024, 5, 15),
    ),
    BrandModel(
      id: '4',
      name: 'Jordan',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      categories: ['Sports', 'Sport Shoes'],
      createdAt: DateTime(2024, 5, 14),
    ),
    BrandModel(
      id: '5',
      name: 'Puma',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      categories: ['Sports', 'Sport Shoes', 'Clothes'],
      createdAt: DateTime(2024, 5, 12),
    ),
    BrandModel(
      id: '6',
      name: 'Apple',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      categories: ['Electronics', 'Mobile', 'Laptop'],
      createdAt: DateTime(2024, 5, 10),
    ),
    BrandModel(
      id: '7',
      name: 'ZARA',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      categories: ['Clothes', 'Shirts'],
      createdAt: DateTime(2024, 4, 28),
    ),
    BrandModel(
      id: '8',
      name: 'Samsung',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      categories: ['Electronics', 'Mobile'],
      createdAt: DateTime(2024, 4, 25),
    ),
    BrandModel(
      id: '9',
      name: 'Kenwood',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      categories: ['Electronics', 'Kitchen Furniture'],
      createdAt: DateTime(2024, 4, 20),
    ),
    BrandModel(
      id: '10',
      name: 'IKEA',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      categories: ['Furniture', 'Bedroom furniture', 'Office furniture'],
      createdAt: DateTime(2024, 4, 15),
    ),
  ];
}
