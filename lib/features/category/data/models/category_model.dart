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
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    this.parentId = '',
    this.image = '',
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate =>
      createdAt != null ? THelperFunctions.getFormattedDate(createdAt!) : '';

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
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      parentId: json['ParentId'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
    );
  }

  static CategoryModel empty() => CategoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: '',
      );

  static List<String> parentCategoryNames(List<CategoryModel> categories) {
    final names = categories.map((c) => c.name).toSet().toList()..sort();
    return ['', ...names];
  }
}
