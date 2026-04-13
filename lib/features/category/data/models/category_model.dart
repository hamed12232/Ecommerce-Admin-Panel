import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

class CategoryModel {
  final String id;
  final String name;
  final String parentCategory;
  final String image;
  final bool isFeatured;
  final DateTime createdAt;

  const CategoryModel({
    required this.id,
    required this.name,
    this.parentCategory = '',
    this.image = '',
    this.isFeatured = false,
    required this.createdAt,
  });

  String get formattedDate => THelperFunctions.getFormattedDate(createdAt);

  /// Dummy data matching the screenshot.
  static List<CategoryModel> dummyCategories = [
    CategoryModel(
      id: '1',
      name: 'Kurtas',
      parentCategory: '',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      createdAt: DateTime(2024, 5, 20),
    ),
    CategoryModel(
      id: '2',
      name: 'Sports Equipments',
      parentCategory: 'Kurtas',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      createdAt: DateTime(2024, 5, 18),
    ),
    CategoryModel(
      id: '3',
      name: 'Kitchen Furniture',
      parentCategory: 'Furniture',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      createdAt: DateTime(2024, 5, 15),
    ),
    CategoryModel(
      id: '4',
      name: 'Office Furniture',
      parentCategory: 'Furniture',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      createdAt: DateTime(2024, 5, 14),
    ),
    CategoryModel(
      id: '5',
      name: 'Laptop',
      parentCategory: 'Electronics',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      createdAt: DateTime(2024, 5, 12),
    ),
    CategoryModel(
      id: '6',
      name: 'Mobile',
      parentCategory: 'Electronics',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      createdAt: DateTime(2024, 5, 10),
    ),
    CategoryModel(
      id: '7',
      name: 'Shirts',
      parentCategory: 'Clothes',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      createdAt: DateTime(2024, 4, 28),
    ),
    CategoryModel(
      id: '8',
      name: 'Electronics',
      parentCategory: '',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      createdAt: DateTime(2024, 4, 25),
    ),
    CategoryModel(
      id: '9',
      name: 'Clothes',
      parentCategory: '',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      createdAt: DateTime(2024, 4, 20),
    ),
    CategoryModel(
      id: '10',
      name: 'Animals',
      parentCategory: '',
      image: 'assets/images/content/default_image.png',
      isFeatured: true,
      createdAt: DateTime(2024, 4, 15),
    ),
    CategoryModel(
      id: '11',
      name: 'Furniture',
      parentCategory: '',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      createdAt: DateTime(2024, 4, 10),
    ),
    CategoryModel(
      id: '12',
      name: 'Jewelry',
      parentCategory: '',
      image: 'assets/images/content/default_image.png',
      isFeatured: false,
      createdAt: DateTime(2024, 4, 5),
    ),
  ];

  /// Returns distinct parent category names for the dropdown.
  static List<String> get parentCategoryNames {
    final names = dummyCategories
        .map((c) => c.name)
        .toSet()
        .toList()
      ..sort();
    return ['', ...names]; // empty string = "No Parent"
  }
}
