import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class BannerModel {
  final String id;
  final String image;
  final String targetScreen;
  final bool isActive;
  final DateTime createdAt;

  const BannerModel({
    required this.id,
    this.image = '',
    this.targetScreen = '',
    this.isActive = false,
    required this.createdAt,
  });

  String get formattedDate => THelperFunctions.getFormattedDate(createdAt);

  /// Available redirect routes
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
