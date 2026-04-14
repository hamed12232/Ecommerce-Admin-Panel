import 'package:yt_ecommerce_admin_panel/core/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/helpers/helper_functions.dart';

/// Attribute for a product (e.g. Color -> [Green, Blue]).
class ProductAttributeModel {
  final String name;
  final List<String> values;

  const ProductAttributeModel({required this.name, required this.values});
}

/// A single product variation built from attribute combinations.
class ProductVariationModel {
  final String id;
  final Map<String, String> attributes; // e.g. {Color: Green, Size: Small}
  final double price;
  final double salePrice;
  final int stock;
  final String image;

  const ProductVariationModel({
    required this.id,
    required this.attributes,
    this.price = 0,
    this.salePrice = 0,
    this.stock = 0,
    this.image = '',
  });

  String get attributeSummary =>
      attributes.entries.map((e) => '${e.key}: ${e.value}').join(', ');
}

enum TProductType { single, variable }

class ProductModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final List<String> images;
  final TProductType productType;
  final int stock;
  final double price;
  final double salePrice;
  final String brand;
  final String brandImage;
  final List<String> categories;
  final bool isPublished;
  final List<ProductAttributeModel> attributes;
  final List<ProductVariationModel> variations;
  final DateTime createdAt;

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
    this.brand = '',
    this.brandImage = '',
    this.categories = const [],
    this.isPublished = true,
    this.attributes = const [],
    this.variations = const [],
    required this.createdAt,
  });

  String get formattedDate => THelperFunctions.getFormattedDate(createdAt);

  /// Human-readable price display for data table.
  String get priceDisplay {
    if (productType == TProductType.variable && variations.isNotEmpty) {
      final prices = variations.map((v) => v.price).toList()..sort();
      final salePrices = variations.map((v) => v.salePrice).where((p) => p > 0).toList();
      if (salePrices.isNotEmpty) {
        salePrices.sort();
        return '\$${salePrices.first} - \$${prices.last}';
      }
      return '\$${prices.first} - \$${prices.last}';
    }
    if (salePrice > 0) return '\$${salePrice.toStringAsFixed(0)}';
    return '\$${price.toStringAsFixed(0)}';
  }

  // ─── Dummy data ───────────────────────────────────────────

  static List<ProductModel> dummyProducts = [
    ProductModel(
      id: '1',
      title: 'Green Nike sports shoe',
      thumbnail: TImages.productImage1,
      images: [],
      productType: TProductType.variable,
      stock: 282,
      price: 334,
      salePrice: 122.6,
      brand: 'Nike',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Sports', 'Sport Shoes'],
      isPublished: true,
      attributes: [
        const ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        const ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
      ],
      variations: [
        const ProductVariationModel(id: 'v1', attributes: {'Color': 'Green', 'Size': 'EU 30'}, price: 334, salePrice: 122.6, stock: 50),
        const ProductVariationModel(id: 'v2', attributes: {'Color': 'Green', 'Size': 'EU 32'}, price: 334, salePrice: 130, stock: 40),
        const ProductVariationModel(id: 'v3', attributes: {'Color': 'Black', 'Size': 'EU 30'}, price: 310, salePrice: 0, stock: 60),
      ],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '2',
      title: 'Blue T-shirt for all ages',
      thumbnail: 'assets/images/content/default_image.png',
      stock: 15,
      price: 30,
      brand: 'ZARA',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Clothes', 'Shirts'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '3',
      title: 'Leather brown Jacket',
      thumbnail: 'assets/images/content/default_image.png',
      stock: 15,
      price: 30,
      brand: 'ZARA',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Clothes'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '4',
      title: '4 Color collar t-shirt dry fit',
      thumbnail: 'assets/images/content/default_image.png',
      productType: TProductType.variable,
      stock: 293,
      price: 334,
      salePrice: 122.6,
      brand: 'ZARA',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Clothes', 'Shirts'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '5',
      title: 'Nike Air Jordan Shoes',
      thumbnail: 'assets/images/content/default_image.png',
      productType: TProductType.variable,
      stock: 81,
      price: 35,
      salePrice: 12.6,
      brand: 'Nike',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Sports', 'Sport Shoes'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '6',
      title: 'TOMI Dog food',
      thumbnail: 'assets/images/content/default_image.png',
      stock: 15,
      price: 10,
      brand: 'Tomi',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Animals'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '7',
      title: 'Nike Air Jordan 19 Blue',
      thumbnail: 'assets/images/content/default_image.png',
      stock: 15,
      price: 200,
      brand: 'Nike',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Sports', 'Sport Shoes'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '8',
      title: 'Nike Air Max Red & Black',
      thumbnail: 'assets/images/content/default_image.png',
      stock: 15,
      price: 400,
      brand: 'Nike',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Sports', 'Sport Shoes'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '9',
      title: 'Nike Basketball shoes Black & Green',
      thumbnail: 'assets/images/content/default_image.png',
      stock: 15,
      price: 400,
      brand: 'Nike',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Sports', 'Sport Shoes'],
      createdAt: DateTime(2024, 7, 2),
    ),
    ProductModel(
      id: '10',
      title: 'Nike wild horse shoes',
      thumbnail: 'assets/images/content/default_image.png',
      stock: 15,
      price: 400,
      brand: 'Nike',
      brandImage: 'assets/images/content/default_image.png',
      categories: ['Sports', 'Sport Shoes'],
      createdAt: DateTime(2024, 7, 2),
    ),
  ];
}
