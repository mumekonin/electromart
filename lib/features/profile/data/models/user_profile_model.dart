import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

/// JSON model for one Fake Store user (GET /users/{id}).
///
/// Example API response:
/// ```json
/// {
///   "id": 1,
///   "email": "john@gmail.com",
///   "username": "johnd",
///   "name": { "firstname": "John", "lastname": "Doe" },
///   "phone": "1-570-236-7033",
///   "address": {
///     "city": "kilcoole",
///     "street": "new road",
///     "number": 7682,
///     "zipcode": "12926-3874",
///     "geolocation": { "lat": "-37.3159", "long": "81.1496" }
///   }
/// }
/// ```
///
/// Why this class exists:
/// - Converts API JSON into a typed Dart object
/// - UI never reads raw `Map<String, dynamic>`
///
/// Why fetch the user separately from login?
/// - Fake Store `POST /auth/login` only returns `{ "token": "..." }`
/// - It does NOT return name, email, phone, or address
/// - So after login we still need `GET /users/1` for the Profile screen
@freezed
abstract class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required int id,
    required String email,
    required String username,
    required UserNameModel name,
    required String phone,
    required UserAddressModel address,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}

/// Nested `name` object from Fake Store.
@freezed
abstract class UserNameModel with _$UserNameModel {
  const factory UserNameModel({
    required String firstname,
    required String lastname,
  }) = _UserNameModel;

  factory UserNameModel.fromJson(Map<String, dynamic> json) =>
      _$UserNameModelFromJson(json);
}

/// Nested `address` object from Fake Store.
@freezed
abstract class UserAddressModel with _$UserAddressModel {
  const factory UserAddressModel({
    required String city,
    required String street,
    required int number,
    required String zipcode,
    required UserGeolocationModel geolocation,
  }) = _UserAddressModel;

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);
}

/// Nested `geolocation` object inside address.
@freezed
abstract class UserGeolocationModel with _$UserGeolocationModel {
  const factory UserGeolocationModel({
    required String lat,
    required String long,
  }) = _UserGeolocationModel;

  factory UserGeolocationModel.fromJson(Map<String, dynamic> json) =>
      _$UserGeolocationModelFromJson(json);
}
