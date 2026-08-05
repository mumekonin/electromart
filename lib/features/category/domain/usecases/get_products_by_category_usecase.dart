import '../../../product/domain/entities/product.dart';
import '../repositories/category_repository.dart';

/// Runs the "get products for one category" business action.
///
/// Why this class exists:
/// - Used when the user taps a category chip (not "All")
/// - Returns the same [Product] entities as the product listing
class GetProductsByCategoryUseCase {
  GetProductsByCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  Future<List<Product>> call(String categoryName) {
    return _repository.getProductsByCategory(categoryName);
  }
}
