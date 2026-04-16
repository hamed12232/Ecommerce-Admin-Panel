import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/services/entity_uploader.dart';

class CategoryModel implements BaseEntity, UploadableEntity {
  @override
  final String id;
  final String name;
  final String parentId;
  final String image;
  final bool isFeatured;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    this.parentId = '',
    this.image = '',
    this.isFeatured = false,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  String get imageUrl => image;

  @override
  List<String>? get additionalImages => null;

  @override
  String get entityId => name.toLowerCase().replaceAll(' ', '_');

  @override
  Map<String, String> get nestedImagePaths => {};

  @override
  CategoryModel copyWithImageUrl(String newImageUrl) {
    return CategoryModel(
      id: id,
      name: name,
      parentId: parentId,
      image: newImageUrl,
      isFeatured: isFeatured,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  CategoryModel copyWithAdditionalImages(List<String> newImages) {
    return this;
  }

  @override
  CategoryModel copyWithNestedImages(Map<String, String> uploadedUrls) {
    return this;
  }

  String get formattedDate => THelperFunctions.getFormattedDate(createdAt);
  String get parentCategory => parentId;

  CategoryModel copyWith({
    String? id,
    String? name,
    String? parentId,
    String? image,
    bool? isFeatured,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'image': image,
      'isFeatured': isFeatured,
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      parentId: json['parentId'] as String? ??
          json['parentCategory'] as String? ??
          '',
      image: json['image'] as String? ?? '',
      isFeatured: json['isFeatured'] as bool? ?? false,
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

  static CategoryModel empty() => CategoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: '',
        createdAt: DateTime.now(),
      );

  static List<String> parentCategoryNames(List<CategoryModel> categories) {
    final names = categories.map((c) => c.name).toSet().toList()..sort();
    return ['', ...names];
  }

  // DEPRECATED - Use Cubit to fetch categories instead
  @Deprecated('Use CategoryCubit to fetch categories')
  static List<CategoryModel> get dummyCategories => [];
}
