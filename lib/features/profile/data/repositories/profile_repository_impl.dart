import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_data_source.dart';
import '../mappers/user_profile_mapper.dart';

/// Concrete [ProfileRepository] using the Fake Store users API.
///
/// Why this class exists:
/// - Talks to [ProfileRemoteDataSource]
/// - Maps models → domain entities for the rest of the app
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<UserProfile> getUserProfile(int userId) async {
    final model = await _remoteDataSource.getUserProfile(userId);
    return UserProfileMapper.toEntity(model);
  }
}
