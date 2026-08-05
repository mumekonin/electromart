import '../entities/cart.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

/// Adds a product to the shopping cart.
///
/// Why this class exists:
/// - Used when the user taps "Add to Cart"
/// - If the product is already in the cart, quantity goes up by 1
class AddToCartUseCase {
  AddToCartUseCase(this._repository);

  final CartRepository _repository;

  Future<Cart> call(CartItem item) {
    return _repository.addToCart(item);
  }
}
