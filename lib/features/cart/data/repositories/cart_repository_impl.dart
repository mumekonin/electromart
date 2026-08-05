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
/// - Saves the cart after every change so it survives app restarts
/// - Maps models ↔ entities for the domain layer
class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._localDataSource);

  final CartLocalDataSource _localDataSource;

  @override
  Future<Cart> getCart() async {
    final models = await _localDataSource.loadCart();
    return _toCart(models);
  }

  @override
  Future<Cart> addToCart(CartItem item) async {
    final models = await _localDataSource.loadCart();
    final index = _indexOfProduct(models, item.productId);

    if (index >= 0) {
      // Product already in cart → increase quantity by 1.
      final existing = models[index];
      models[index] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      // New product → add with at least quantity 1.
      final quantity = item.quantity < 1 ? 1 : item.quantity;
      models.add(CartItemMapper.toModel(item.copyWithQuantity(quantity)));
    }

    await _localDataSource.saveCart(models);
    return _toCart(models);
  }

  @override
  Future<Cart> removeFromCart(int productId) async {
    final models = await _localDataSource.loadCart();
    models.removeWhere((item) => item.productId == productId);
    await _localDataSource.saveCart(models);
    return _toCart(models);
  }

  @override
  Future<Cart> increaseQuantity(int productId) async {
    final models = await _localDataSource.loadCart();
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
    final models = await _localDataSource.loadCart();
    final index = _indexOfProduct(models, productId);

    if (index < 0) {
      return _toCart(models);
    }

    final existing = models[index];
    final newQuantity = existing.quantity - 1;

    if (newQuantity <= 0) {
      // Quantity hit zero → remove the line completely.
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
