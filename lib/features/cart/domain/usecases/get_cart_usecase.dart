import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

/// Loads the current shopping cart from local storage.
///
/// Why this class exists:
/// - Presentation will call this to show cart items / badge count
/// - Keeps "get cart" as one clear business action
class GetCartUseCase {
  GetCartUseCase(this._repository);

  final CartRepository _repository;

  Future<Cart> call() {
    return _repository.getCart();
  }
}
