import '../../../product/domain/entities/product.dart';
import '../entities/category.dart';

/// Abstract category contract used by the domain layer.
///
/// Why this class exists:
/// - Domain defines WHAT category browsing can do
/// - Data layer defines HOW (API products + keyword matching)
abstract class CategoryRepository {
  /// Returns ElectroMart electronics departments.
  Future<List<Category>> getCategories();

  /// Returns electronics products that match one department.
  Future<List<Product>> getProductsByCategory(String categoryName);
}
