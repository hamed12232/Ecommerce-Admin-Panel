import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class BannerModel implements BaseEntity {
  @override
  final String id;
  final String image;
  final String targetScreen;
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  const BannerModel({
    required this.id,
    this.image = '',
    this.targetScreen = '',
    this.isActive = false,
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate =>
      createdAt != null ? THelperFunctions.getFormattedDate(createdAt!) : '';

  BannerModel copyWith({
    String? id,
    String? image,
    String? targetScreen,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      targetScreen: targetScreen ?? this.targetScreen,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ImageUrl': image,
      'TargetScreen': targetScreen,
      'Active': isActive,
    
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['Id'] ?? json['id'] ?? '',
      image: json['ImageUrl'] ?? json['Image'] ?? '',
      targetScreen: json['TargetScreen'] ?? '',
      isActive: json['Active'] ?? false,
    );
  }

  static const List<String> availableRoutes = [
    '/on-boarding',
    '/search',
    '/home',
    '/categories',
    '/brands',
    '/products',
    '/orders',
    '/settings',
  ];

  @Deprecated('Use BannerCubit to fetch banners')
  static List<BannerModel> get dummyBanners => [];
}
