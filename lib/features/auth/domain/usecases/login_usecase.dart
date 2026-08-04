import '../entities/user_session.dart';
import '../repositories/auth_repository.dart';

/// Runs the "login" business action.
///
/// Why this class exists:
/// - Keeps the login steps in one place
/// - Presentation calls this use case instead of the repository directly
/// - Easy to read: LoginUseCase = "user wants to log in"
class LoginUseCase {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  /// Executes login and returns the new [UserSession].
  Future<UserSession> call({
    required String username,
    required String password,
  }) {
    return _repository.login(
      username: username,
      password: password,
    );
  }
}
