import '../../../product/domain/entities/product.dart';
import '../entities/category.dart';

/// Abstract category contract used by the domain layer.
///
/// Why this class exists:
/// - Domain defines WHAT category browsing can do
/// - Data layer defines HOW (API calls + mapping)
abstract class CategoryRepository {
  /// Fetches every category name from Fake Store.
  Future<List<Category>> getCategories();

  /// Fetches products that belong to [categoryName].
  Future<List<Product>> getProductsByCategory(String categoryName);
}
