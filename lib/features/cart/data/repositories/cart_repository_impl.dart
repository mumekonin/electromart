import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasource/cart_local_data_source.dart';
import '../mappers/cart_item_mapper.dart';
import '../models/cart_item_model.dart';

/// Concrete [CartRepository] using SharedPreferences.
///
/// Why this class exists:
/// - Implements add / remove / quantity / clear rules
/// - Prevents duplicate product lines (same productId → one row)
/// - Prevents negative or zero quantities from staying in the cart
/// - Saves the cart after every change so it survives app restarts
class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._localDataSource);

  final CartLocalDataSource _localDataSource;

  @override
  Future<Cart> getCart() async {
    final models = await _localDataSource.loadCart();
    final normalized = _normalize(models);
    // If we cleaned duplicates / bad quantities, persist the clean version.
    if (normalized.length != models.length) {
      await _localDataSource.saveCart(normalized);
    }
    return _toCart(normalized);
  }

  @override
  Future<Cart> addToCart(CartItem item) async {
    final models = _normalize(await _localDataSource.loadCart());
    final index = _indexOfProduct(models, item.productId);

    // Always add at least 1 unit.
    final amountToAdd = item.quantity < 1 ? 1 : item.quantity;

    if (index >= 0) {
      // Duplicate product → increase quantity on the existing row.
      // Never create a second line for the same productId.
      final existing = models[index];
      models[index] = existing.copyWith(
        quantity: existing.quantity + amountToAdd,
      );
    } else {
      // New product → one new cart line.
      models.add(
        CartItemMapper.toModel(item.copyWithQuantity(amountToAdd)),
      );
    }

    await _localDataSource.saveCart(models);
    return _toCart(models);
  }

  @override
  Future<Cart> removeFromCart(int productId) async {
    final models = _normalize(await _localDataSource.loadCart());
    models.removeWhere((item) => item.productId == productId);
    await _localDataSource.saveCart(models);
    return _toCart(models);
  }

  @override
  Future<Cart> increaseQuantity(int productId) async {
    final models = _normalize(await _localDataSource.loadCart());
    final index = _indexOfProduct(models, productId);

    if (index < 0) {
      return _toCart(models);
    }

    final existing = models[index];
    models[index] = existing.copyWith(quantity: existing.quantity + 1);
    await _localDataSource.saveCart(models);
    return _toCart(models);
  }

  @override
  Future<Cart> decreaseQuantity(int productId) async {
    final models = _normalize(await _localDataSource.loadCart());
    final index = _indexOfProduct(models, productId);

    if (index < 0) {
      return _toCart(models);
    }

    final existing = models[index];
    // Never go below zero. At 1 → remove the line instead.
    final newQuantity = existing.quantity - 1;

    if (newQuantity <= 0) {
      models.removeAt(index);
    } else {
      models[index] = existing.copyWith(quantity: newQuantity);
    }

    await _localDataSource.saveCart(models);
    return _toCart(models);
  }

  @override
  Future<Cart> clearCart() async {
    await _localDataSource.clearCart();
    return Cart.empty();
  }

  /// Merges duplicate productIds and drops invalid quantities.
  ///
  /// Why:
  /// - Old / corrupted JSON might contain the same product twice
  /// - Quantity must always be a positive integer
  List<CartItemModel> _normalize(List<CartItemModel> models) {
    final merged = <int, CartItemModel>{};

    for (final item in models) {
      if (item.quantity <= 0) continue;

      final existing = merged[item.productId];
      if (existing == null) {
        merged[item.productId] = item;
      } else {
        merged[item.productId] = existing.copyWith(
          quantity: existing.quantity + item.quantity,
        );
      }
    }

    return merged.values.toList();
  }

  /// Finds the list index for a product id, or -1 if missing.
  int _indexOfProduct(List<CartItemModel> models, int productId) {
    for (var i = 0; i < models.length; i++) {
      if (models[i].productId == productId) {
        return i;
      }
    }
    return -1;
  }

  /// Maps models into a domain [Cart] with totals.
  Cart _toCart(List<CartItemModel> models) {
    final items = models.map(CartItemMapper.toEntity).toList();
    return Cart(items: items);
  }
}
