import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item_model.dart';

/// Saves and loads the shopping cart on the device.
///
/// Why this class exists:
/// - SharedPreferences only stores simple values (String, int, bool, ...)
/// - We store the whole cart as one JSON string under a single key
/// - Repository talks to this class instead of SharedPreferences directly
///
/// Storage shape:
/// key   = "shopping_cart"
/// value = '[{"productId":9,"title":"...","price":64.0,"image":"...","quantity":2}]'
class CartLocalDataSource {
  CartLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  /// Key used inside SharedPreferences.
  static const String cartKey = 'shopping_cart';

  /// Saves the full cart list as a JSON string.
  Future<void> saveCart(List<CartItemModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString(cartKey, jsonString);
  }

  /// Loads the cart list from SharedPreferences.
  ///
  /// Returns an empty list when:
  /// - nothing is saved yet, or
  /// - the saved JSON is broken (we clear it so the app can recover)
  Future<List<CartItemModel>> loadCart() async {
    final jsonString = _prefs.getString(cartKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final decoded = jsonDecode(jsonString);

      if (decoded is! List) {
        await clearCart();
        return [];
      }

      final items = <CartItemModel>[];

      for (final item in decoded) {
        if (item is! Map) continue;

        final model = CartItemModel.fromJson(
          Map<String, dynamic>.from(item),
        );

        // Skip invalid / negative quantities from corrupted data.
        if (model.quantity > 0) {
          items.add(model);
        }
      }

      return items;
    } catch (_) {
      // Broken JSON should not crash the app — reset the cart key.
      await clearCart();
      return [];
    }
  }

  /// Deletes the saved cart JSON.
  Future<void> clearCart() async {
    await _prefs.remove(cartKey);
  }
}
