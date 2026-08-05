import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Increases the quantity of one cart item by 1.
///
/// Why this class exists:
/// - Used by the "+" button on a cart row
class IncreaseQuantityUseCase {
  IncreaseQuantityUseCase(this._repository);

  final CartRepository _repository;

  Future<Cart> call(int productId) {
    return _repository.increaseQuantity(productId);
  }
}
