import '../../../auth/domain/repositories/auth_repository.dart';

/// Clears the saved login session (logout).
///
/// Why this lives in the Profile feature:
/// - The Profile screen is where the user taps Logout
/// - It reuses [AuthRepository] so we do not duplicate SharedPreferences code
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
