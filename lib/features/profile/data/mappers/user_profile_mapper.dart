import '../../domain/entities/user_profile.dart';
import '../models/user_profile_model.dart';

/// Converts [UserProfileModel] (data) into [UserProfile] (domain).
///
/// Why this class exists:
/// - Domain code should not depend on freezed / JSON models
/// - One place to map nested API fields into simple domain fields
class UserProfileMapper {
  UserProfileMapper._();

  static UserProfile toEntity(UserProfileModel model) {
    return UserProfile(
      id: model.id,
      email: model.email,
      username: model.username,
      firstName: model.name.firstname,
      lastName: model.name.lastname,
      phone: model.phone,
      address: UserAddress(
        city: model.address.city,
        street: model.address.street,
        number: model.address.number,
        zipcode: model.address.zipcode,
      ),
    );
  }
}
