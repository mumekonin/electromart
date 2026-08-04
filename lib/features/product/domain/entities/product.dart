/// Domain entity for a store product.
///
/// Why this class exists:
/// - UI and use cases work with plain Dart objects
/// - No JSON / freezed code belongs in the domain layer
/// - Keeps business data independent from the Fake Store API shape
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating rating;
}

/// Rating information for a [Product].
class ProductRating {
  const ProductRating({
    required this.rate,
    required this.count,
  });

  /// Average score (example: 3.9).
  final double rate;

  /// How many people rated this product.
  final int count;
}
