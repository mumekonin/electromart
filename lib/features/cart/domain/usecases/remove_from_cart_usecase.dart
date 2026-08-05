import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Removes one product line from the cart completely.
///
/// Why this class exists:
/// - Used when the user taps delete / remove on a cart row
class RemoveFromCartUseCase {
  RemoveFromCartUseCase(this._repository);

  final CartRepository _repository;

  Future<Cart> call(int productId) {
    return _repository.removeFromCart(productId);
  }
}
