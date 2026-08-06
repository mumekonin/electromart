/// Domain object for the signed-in user's profile.
///
/// Why this class exists:
/// - Domain / UI work with plain Dart objects (no JSON, no freezed)
/// - Holds display-friendly getters like [fullName] and [formattedAddress]
///
/// Note: Fake Store login does not return this data — Profile loads it
/// with a separate `GET /users/{id}` call after the user is logged in.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final UserAddress address;

  /// "John Doe" style display name for the profile header.
  String get fullName {
    final first = firstName.trim();
    final last = lastName.trim();

    if (first.isEmpty && last.isEmpty) {
      return username;
    }

    return '$first $last'.trim();
  }

  /// One-line address for the profile details card.
  String get formattedAddress => address.displayLine;

  /// True when we have almost no useful identity to show.
  bool get isUnavailable {
    return username.trim().isEmpty && email.trim().isEmpty;
  }
}

/// Simple address value object (no Flutter / JSON dependencies).
class UserAddress {
  const UserAddress({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  final String city;
  final String street;
  final int number;
  final String zipcode;

  /// Example: "7682 new road, kilcoole 12926-3874"
  String get displayLine {
    return '$number $street, $city $zipcode';
  }
}
