import '../entities/cart.dart';
import '../entities/cart_item.dart';

/// Abstract cart contract used by the domain layer.
///
/// Why this class exists:
/// - Domain defines WHAT the cart can do
/// - Data layer defines HOW (SharedPreferences + JSON)
/// - Use cases depend on this interface, not on storage details
abstract class CartRepository {
  /// Loads the full cart (items + totals).
  Future<Cart> getCart();

  /// Adds a product to the cart.
  ///
  /// If the product is already in the cart, quantity increases by 1.
  Future<Cart> addToCart(CartItem item);

  /// Removes one product line completely (any quantity).
  Future<Cart> removeFromCart(int productId);

  /// Increases quantity of one product by 1.
  Future<Cart> increaseQuantity(int productId);

  /// Decreases quantity of one product by 1.
  ///
  /// If quantity reaches 0, the item is removed.
  Future<Cart> decreaseQuantity(int productId);

  /// Removes every item from the cart.
  Future<Cart> clearCart();
}
