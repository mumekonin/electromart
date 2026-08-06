// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    _UserProfileModel(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      username: json['username'] as String,
      name: UserNameModel.fromJson(json['name'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      address: UserAddressModel.fromJson(
        json['address'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UserProfileModelToJson(_UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'phone': instance.phone,
      'address': instance.address,
    };

_UserNameModel _$UserNameModelFromJson(Map<String, dynamic> json) =>
    _UserNameModel(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
    );

Map<String, dynamic> _$UserNameModelToJson(_UserNameModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
    };

_UserAddressModel _$UserAddressModelFromJson(Map<String, dynamic> json) =>
    _UserAddressModel(
      city: json['city'] as String,
      street: json['street'] as String,
      number: (json['number'] as num).toInt(),
      zipcode: json['zipcode'] as String,
      geolocation: UserGeolocationModel.fromJson(
        json['geolocation'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UserAddressModelToJson(_UserAddressModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'number': instance.number,
      'zipcode': instance.zipcode,
      'geolocation': instance.geolocation,
    };

_UserGeolocationModel _$UserGeolocationModelFromJson(
  Map<String, dynamic> json,
) => _UserGeolocationModel(
  lat: json['lat'] as String,
  long: json['long'] as String,
);

Map<String, dynamic> _$UserGeolocationModelToJson(
  _UserGeolocationModel instance,
) => <String, dynamic>{'lat': instance.lat, 'long': instance.long};
