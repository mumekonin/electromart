import '../repositories/auth_repository.dart';

/// Clears the saved login session (logout).
///
/// Why this use case exists:
/// - Profile and Settings both need to log out
/// - They call [AuthNotifier.logout], which uses this use case
/// - Session clearing stays in the Auth feature (single owner)
///
/// What it clears:
/// - The JWT token
/// - The "is logged in" flag
///
/// It does NOT clear the shopping cart (cart is a separate key).
class LogoutUseCase {
  LogoutUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> call() {
    return _authRepository.logout();
  }
}
