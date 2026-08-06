import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_exception.dart';
import '../models/user_profile_model.dart';

/// Fetches user profile data from the Fake Store API.
///
/// Why this class exists:
/// - Keeps Dio / JSON details out of the repository
/// - Turns the HTTP response into a [UserProfileModel]
/// - Converts unexpected failures into [NetworkException]
class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this._apiService);

  final ApiService _apiService;

  /// GET /users/{id} and parse the JSON body.
  Future<UserProfileModel> getUserProfile(int userId) async {
    try {
      final response = await _apiService.get(ApiConstants.userById(userId));
      final data = response.data;

      // Fake Store should return one JSON object for a single user.
      if (data is! Map<String, dynamic>) {
        throw const NetworkException(
          'Invalid profile response from server.',
        );
      }

      return UserProfileModel.fromJson(data);
    } on NetworkException {
      // Already a friendly network error — pass it up unchanged.
      rethrow;
    } catch (_) {
      throw const NetworkException(
        'Something went wrong while loading your profile.',
      );
    }
  }
}
