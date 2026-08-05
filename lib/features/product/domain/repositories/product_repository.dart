import '../entities/product.dart';

/// Abstract product contract used by the domain layer.
///
/// Why this class exists:
/// - Domain defines WHAT we can do with products
/// - Data layer defines HOW (API call + mapping)
/// - Use cases depend on this interface, not on Dio
abstract class ProductRepository {
  /// Fetches every product from the remote API.
  Future<List<Product>> getAllProducts();

  /// Fetches one product by its Fake Store id.
  Future<Product> getProductById(int id);
}
