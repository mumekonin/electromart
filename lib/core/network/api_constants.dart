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

  // --- Products ---

  /// GET all products, or POST a product.
  static const String products = '/products';

  /// GET all category names.
  static const String categories = '/products/categories';

  /// GET / PUT / DELETE one product by id.
  static String productById(int id) => '/products/$id';

  /// GET products that belong to one category.
  ///
  /// Category names may contain spaces (example: "men's clothing"),
  /// so we encode them for a safe URL path.
  static String productsByCategory(String category) =>
      '/products/category/${Uri.encodeComponent(category)}';
}
