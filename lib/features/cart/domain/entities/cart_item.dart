/// One product line inside the shopping cart.
///
/// Why this class exists:
/// - Domain code works with plain Dart objects (no JSON)
/// - Stores a snapshot of product info (title, price, image)
///   so the cart still works offline after leaving Product Details
///
/// Rule: each [productId] appears at most once in the cart.
/// If the user adds the same product again, quantity goes up.
class CartItem {
  const CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  /// Fake Store product id (unique key inside the cart).
  final int productId;

  /// Product title shown in the cart.
  final String title;

  /// Unit price at the time the item was added.
  final double price;

  /// Product image URL.
  final String image;

  /// How many units of this product are in the cart.
  /// Always expected to be >= 1 in a valid cart.
  final int quantity;

  /// Price for this line: unit price × quantity.
  double get lineTotal => price * quantity;

  /// Returns a copy with a new quantity.
  ///
  /// Negative values are clamped to 0 (caller usually removes the item).
  CartItem copyWithQuantity(int newQuantity) {
    final safeQuantity = newQuantity < 0 ? 0 : newQuantity;

    return CartItem(
      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: safeQuantity,
    );
  }
}
