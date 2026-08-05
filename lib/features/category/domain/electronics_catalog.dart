import 'entities/category.dart';

/// ElectroMart electronics departments shown on Home.
///
/// Why this class exists:
/// - Fake Store API does not provide AirPods / Laptop / TV categories
/// - We still fetch real products from the API
/// - Then we group them into these electronics departments by keywords
///
/// Tip for beginners:
/// If a chip shows "No products", Fake Store simply has no matching item yet.
class ElectronicsCatalog {
  ElectronicsCatalog._();

  /// All electronics department chips (order = chip order).
  static const List<Category> categories = [
    Category(
      name: 'laptops',
      displayName: 'Laptops',
      keywords: [
        'laptop',
        'notebook',
        'ultrabook',
        'macbook',
        'chromebook',
      ],
    ),
    Category(
      name: 'tvs',
      displayName: 'TVs',
      keywords: [
        'tv',
        'television',
        'smart tv',
        'oled tv',
        'qled tv',
      ],
    ),
    Category(
      name: 'airpods',
      displayName: 'AirPods',
      keywords: [
        'airpods',
        'earbuds',
        'earphone',
        'headphone',
        'headset',
        'buds',
      ],
    ),
    Category(
      name: 'smartwatches',
      displayName: 'Smartwatches',
      keywords: [
        'smartwatch',
        'smart watch',
        'wearable',
        'fitness tracker',
        'apple watch',
      ],
    ),
    Category(
      name: 'phones',
      displayName: 'Phones',
      keywords: [
        'phone',
        'smartphone',
        'iphone',
        'android',
        'mobile',
      ],
    ),
    Category(
      name: 'monitors',
      displayName: 'Monitors',
      keywords: [
        'monitor',
        'display',
        'ips',
        'ultrawide',
        'curved gaming monitor',
      ],
    ),
    Category(
      name: 'storage',
      displayName: 'Storage',
      keywords: [
        'ssd',
        'hard drive',
        'hdd',
        'external hard',
        'portable external',
        'flash',
        'storage',
      ],
    ),
    Category(
      name: 'gaming',
      displayName: 'Gaming',
      keywords: [
        'gaming',
        'playstation',
        'xbox',
        'nintendo',
        'console',
      ],
    ),
  ];

  /// Finds a department by its [name], or null if unknown.
  static Category? findByName(String name) {
    for (final category in categories) {
      if (category.name == name) {
        return category;
      }
    }
    return null;
  }
}
