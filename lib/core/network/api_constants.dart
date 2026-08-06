/// Holds shared networking constants for ElectroMart.
///
/// Why this class exists:
/// - One place for the Fake Store API base URL and timeouts
/// - Avoids typing URLs by hand in many files (typos are easy to make)
/// - Makes it simple to change the API host later
class ApiConstants {
  // Private constructor — use the static values only.
  ApiConstants._();

  /// Fake Store API root URL.
  /// All requests are built on top of this base.
  static const String baseUrl = 'https://fakestoreapi.com';

  /// How long we wait to open a connection.
  static const Duration connectTimeout = Duration(seconds: 20);

  /// How long we wait for the server to send a response.
  static const Duration receiveTimeout = Duration(seconds: 20);

  // --- Auth ---

  /// POST body: { "username": "...", "password": "..." }
  static const String login = '/auth/login';

  // --- Users / Profile ---

  /// Fake Store login only returns a JWT token — not the user id or profile.
  /// So Profile must call GET /users/{id} separately.
  ///
  /// We always load user `1` as the demo profile (per project requirement).
  /// The login username may differ from this user's username — that is a
  /// Fake Store limitation, not an ElectroMart bug.
  static const int demoProfileUserId = 1;

  /// GET one user by id (used by the Profile feature).
  static String userById(int id) => '/users/$id';

  // --- Products ---

  /// GET all products, or POST a product.
  static const String products = '/products';

  /// GET all category names.
  static const String categories = '/products/categories';

  /// ElectroMart is an electronics store.
  ///
  /// Fake Store also returns clothing / jewelry — we ignore those
  /// and only keep this category name from the API.
  static const String electronicsCategory = 'electronics';

  /// Returns true when [category] is the electronics category.
  static bool isElectronicsCategory(String category) {
    return category.toLowerCase() == electronicsCategory;
  }

  /// GET / PUT / DELETE one product by id.
  static String productById(int id) => '/products/$id';

  /// GET products that belong to one category.
  ///
  /// Category names are encoded for a safe URL path.
  static String productsByCategory(String category) =>
      '/products/category/${Uri.encodeComponent(category)}';
}
