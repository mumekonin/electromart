import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_exception.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

/// Talks to Fake Store Auth API.
///
/// Why this class exists:
/// - Isolates HTTP login details from the repository
/// - Uses the shared [ApiService] (one Dio client for the whole app)
/// - Turns API JSON into [LoginResponseModel]
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._apiService);

  final ApiService _apiService;

  /// POST /auth/login
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _apiService.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      final data = response.data;

      // Fake Store should return a JSON object with a "token" field.
      if (data is! Map<String, dynamic>) {
        throw const NetworkException(
          'Invalid response from server. Please try again.',
        );
      }

      return LoginResponseModel.fromJson(data);
    } on NetworkException catch (exception) {
      // Make wrong credentials clearer for the login screen.
      if (exception.statusCode == 401) {
        throw const NetworkException(
          'Wrong username or password.',
          statusCode: 401,
        );
      }
      rethrow;
    } catch (error) {
      if (error is NetworkException) rethrow;
      throw const NetworkException(
        'Something went wrong. Please try again.',
      );
    }
  }
}
