import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Removes every item from the shopping cart.
///
/// Why this class exists:
/// - Used by a "Clear cart" action (and later after checkout)
class ClearCartUseCase {
  ClearCartUseCase(this._repository);

  final CartRepository _repository;

  Future<Cart> call() {
    return _repository.clearCart();
  }
}
