import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

/// JSON returned by POST /auth/login.
///
/// Example:
/// `{ "token": "eyJhbGciOiJIUzI1NiIsInR..." }`
///
/// Why this class exists:
/// - Parses the JWT safely into a typed Dart object
/// - UI never reads raw JSON maps
@freezed
abstract class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    required String token,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
