import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Runs the "get product details" business action.
///
/// Why this class exists:
/// - Presentation asks for ONE product by id
/// - Keeps details logic separate from the "get all products" use case
class GetProductDetailsUseCase {
  GetProductDetailsUseCase(this._repository);

  final ProductRepository _repository;

  /// Returns a single [Product] for the given Fake Store id.
  Future<Product> call(int id) {
    return _repository.getProductById(id);
  }
}
