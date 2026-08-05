import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Decreases the quantity of one cart item by 1.
///
/// Why this class exists:
/// - Used by the "−" button on a cart row
/// - If quantity becomes 0, the item is removed from the cart
class DecreaseQuantityUseCase {
  DecreaseQuantityUseCase(this._repository);

  final CartRepository _repository;

  Future<Cart> call(int productId) {
    return _repository.decreaseQuantity(productId);
  }
}
