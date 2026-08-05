import '../../../product/domain/entities/product.dart';
import '../repositories/category_repository.dart';

/// Runs the "get products for one electronics department" action.
///
/// Why this class exists:
/// - Used when the user taps a chip like Laptops or AirPods
/// - Returns the same [Product] entities as the product listing
class GetProductsByCategoryUseCase {
  GetProductsByCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  Future<List<Product>> call(String categoryName) {
    return _repository.getProductsByCategory(categoryName);
  }
}
