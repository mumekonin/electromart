/// One product line inside the shopping cart.
///
/// Why this class exists:
/// - Domain code works with plain Dart objects (no JSON)
/// - Stores a snapshot of product info (title, price, image)
///   so the cart still works offline after leaving Product Details
class CartItem {
  const CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  /// Fake Store product id.
  final int productId;

  /// Product title shown in the cart.
  final String title;

  /// Unit price at the time the item was added.
  final double price;

  /// Product image URL.
  final String image;

  /// How many units of this product are in the cart.
  final int quantity;

  /// Price for this line: unit price × quantity.
  double get lineTotal => price * quantity;

  /// Returns a copy with a new quantity (used by increase / decrease).
  CartItem copyWithQuantity(int newQuantity) {
    return CartItem(
      productId: productId,
      title: title,
      price: price,
      image: image,
      quantity: newQuantity,
    );
  }
}
