import '../../../product/domain/entities/product.dart';

/// One electronics department in ElectroMart.
///
/// Why this class exists:
/// - Fake Store only has a single "electronics" category
/// - ElectroMart needs store departments like Laptops, TVs, AirPods
/// - [keywords] help match API products into the right chip
class Category {
  const Category({
    required this.name,
    required this.displayName,
    required this.keywords,
  });

  /// Internal id used by providers (example: "laptops").
  final String name;

  /// Label shown on the category chip.
  final String displayName;

  /// Words we look for in a product title / description.
  final List<String> keywords;

  /// Returns true when this product belongs in this department.
  bool matchesProduct(Product product) {
    final text = '${product.title} ${product.description}'.toLowerCase();

    for (final keyword in keywords) {
      if (text.contains(keyword.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  @override
  bool operator ==(Object other) {
    return other is Category && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
