import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

/// Helper so both `int` and `double` JSON numbers become [double].
double _doubleFromJson(dynamic value) {
  if (value is num) return value.toDouble();
  return 0;
}

/// JSON model for one Fake Store product.
///
/// Example API item:
/// ```json
/// {
///   "id": 1,
///   "title": "Fjallraven Backpack",
///   "price": 109.95,
///   "description": "...",
///   "category": "men's clothing",
///   "image": "https://...",
///   "rating": { "rate": 3.9, "count": 120 }
/// }
/// ```
///
/// Why this class exists:
/// - Converts API JSON into a typed Dart object
/// - UI never reads raw `Map<String, dynamic>`
@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required int id,
    required String title,
    @JsonKey(fromJson: _doubleFromJson) required double price,
    required String description,
    required String category,
    required String image,
    required RatingModel rating,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

/// Nested rating object from Fake Store API.
@freezed
abstract class RatingModel with _$RatingModel {
  const factory RatingModel({
    @JsonKey(fromJson: _doubleFromJson) required double rate,
    required int count,
  }) = _RatingModel;

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
