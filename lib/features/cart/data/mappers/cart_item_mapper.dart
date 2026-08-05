import '../../domain/entities/cart_item.dart';
import '../models/cart_item_model.dart';

/// Converts between [CartItemModel] (data) and [CartItem] (domain).
///
/// Why this class exists:
/// - Keeps JSON models out of the domain layer
/// - One place for cart item mapping
class CartItemMapper {
  CartItemMapper._();

  static CartItem toEntity(CartItemModel model) {
    return CartItem(
      productId: model.productId,
      title: model.title,
      price: model.price,
      image: model.image,
      quantity: model.quantity,
    );
  }

  static CartItemModel toModel(CartItem entity) {
    return CartItemModel(
      productId: entity.productId,
      title: entity.title,
      price: entity.price,
      image: entity.image,
      quantity: entity.quantity,
    );
  }
}
