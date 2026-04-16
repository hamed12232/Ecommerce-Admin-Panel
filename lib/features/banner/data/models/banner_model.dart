import 'package:yt_ecommerce_admin_panel/core/data/repositories/base_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class BannerModel implements BaseEntity {
  @override
  final String id;
  final String image;
  final String targetScreen;
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  const BannerModel({
    required this.id,
    this.image = '',
    this.targetScreen = '',
    this.isActive = false,
    required this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => THelperFunctions.getFormattedDate(createdAt);

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
      'id': id,
      'image': image,
      'targetScreen': targetScreen,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as String? ?? '',
      image: json['image'] as String? ?? '',
      targetScreen: json['targetScreen'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? false,
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

  static List<BannerModel> dummyBanners = [
    BannerModel(
      id: '1',
      image: 'assets/images/content/default_image.png',
      targetScreen: '/search',
      isActive: true,
      createdAt: DateTime(2024, 5, 20),
    ),
    BannerModel(
      id: '2',
      image: 'assets/images/content/default_image.png',
      targetScreen: '/search',
      isActive: true,
      createdAt: DateTime(2024, 5, 18),
    ),
    BannerModel(
      id: '3',
      image: 'assets/images/content/default_image.png',
      targetScreen: '/search',
      isActive: true,
      createdAt: DateTime(2024, 5, 15),
    ),
    BannerModel(
      id: '4',
      image: 'assets/images/content/default_image.png',
      targetScreen: '/home',
      isActive: false,
      createdAt: DateTime(2024, 5, 14),
    ),
    BannerModel(
      id: '5',
      image: 'assets/images/content/default_image.png',
      targetScreen: '/on-boarding',
      isActive: true,
      createdAt: DateTime(2024, 5, 12),
    ),
  ];
}
