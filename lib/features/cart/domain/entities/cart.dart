import 'cart_item.dart';

/// The full shopping cart (a list of [CartItem]s + totals).
///
/// Why this class exists:
/// - Gives use cases / future UI one object to work with
/// - Calculates subtotal and total quantity in one place
class Cart {
  const Cart({required this.items});

  /// Empty cart helper.
  factory Cart.empty() => const Cart(items: []);

  final List<CartItem> items;

  /// True when there are no items.
  bool get isEmpty => items.isEmpty;

  /// True when the cart has at least one item.
  bool get isNotEmpty => items.isNotEmpty;

  /// Sum of all line totals (price × quantity for each item).
  double get subtotal {
    var total = 0.0;
    for (final item in items) {
      total += item.lineTotal;
    }
    return total;
  }

  /// Sum of all quantities across every cart line.
  int get totalQuantity {
    var total = 0;
    for (final item in items) {
      total += item.quantity;
    }
    return total;
  }
}
