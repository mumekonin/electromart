import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

/// Helper so both `int` and `double` JSON numbers become [double].
double _doubleFromJson(dynamic value) {
  if (value is num) return value.toDouble();
  return 0;
}

/// JSON model for one cart line saved in SharedPreferences.
///
/// Example JSON item:
/// ```json
/// {
///   "productId": 9,
///   "title": "WD 2TB Elements Portable External Hard Drive",
///   "price": 64.0,
///   "image": "https://...",
///   "quantity": 2
/// }
/// ```
///
/// Why this class exists:
/// - Converts cart lines to / from JSON for local storage
/// - Domain [CartItem] stays free of serialization code
@freezed
abstract class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    required int productId,
    required String title,
    @JsonKey(fromJson: _doubleFromJson) required double price,
    required String image,
    required int quantity,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);
}
