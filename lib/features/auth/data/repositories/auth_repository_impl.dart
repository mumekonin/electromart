import '../../../../core/network/network_exception.dart';
import '../../../../core/storage/session_storage.dart';
import '../../domain/entities/user_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/login_request_model.dart';

/// Concrete [AuthRepository] using API + local storage.
///
/// Why this class exists:
/// - Implements the domain repository contract
/// - Coordinates remote login and saving the JWT locally
/// - Presentation never calls Dio or SharedPreferences here directly
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required SessionStorage sessionStorage,
  })  : _remoteDataSource = remoteDataSource,
        _sessionStorage = sessionStorage;

  final AuthRemoteDataSource _remoteDataSource;
  final SessionStorage _sessionStorage;

  @override
  Future<UserSession> login({
    required String username,
    required String password,
  }) async {
    final request = LoginRequestModel(
      username: username,
      password: password,
    );

    final response = await _remoteDataSource.login(request);

    if (response.token.isEmpty) {
      throw const NetworkException(
        'Login failed. No token received from server.',
      );
    }

    // Persist session so the user stays logged in next time.
    await _sessionStorage.saveToken(response.token);

    return UserSession(
      token: response.token,
      isLoggedIn: true,
    );
  }

  @override
  Future<UserSession?> restoreSession() async {
    if (!_sessionStorage.isLoggedIn()) {
      return null;
    }

    final token = _sessionStorage.getToken();
    if (token == null || token.isEmpty) {
      return null;
    }

    return UserSession(
      token: token,
      isLoggedIn: true,
    );
  }

  @override
  Future<void> logout() async {
    await _sessionStorage.clearSession();
  }
}
