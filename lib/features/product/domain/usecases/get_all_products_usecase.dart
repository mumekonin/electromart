import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Runs the "get all products" business action.
///
/// Why this class exists:
/// - Presentation calls this instead of the repository directly
/// - Easy to read: GetAllProductsUseCase = "load the product list"
class GetAllProductsUseCase {
  GetAllProductsUseCase(this._repository);

  final ProductRepository _repository;

  /// Returns every product from the store.
  Future<List<Product>> call() {
    return _repository.getAllProducts();
  }
}
