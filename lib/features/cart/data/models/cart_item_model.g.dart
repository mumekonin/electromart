// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    _CartItemModel(
      productId: (json['productId'] as num).toInt(),
      title: json['title'] as String,
      price: _doubleFromJson(json['price']),
      image: json['image'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$CartItemModelToJson(_CartItemModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'price': instance.price,
      'image': instance.image,
      'quantity': instance.quantity,
    };
