import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_exception.dart';
import '../../../product/data/models/product_model.dart';

/// Talks to Fake Store category endpoints.
///
/// Why this class exists:
/// - Isolates category HTTP calls from the repository
/// - Reuses [ProductModel] for products-by-category responses
/// - Uses the shared [ApiService]
class CategoryRemoteDataSource {
  CategoryRemoteDataSource(this._apiService);

  final ApiService _apiService;

  /// GET /products/categories
  ///
  /// Fake Store returns a JSON array of strings.
  Future<List<String>> getCategories() async {
    try {
      final response = await _apiService.get(ApiConstants.categories);
      final data = response.data;

      if (data is! List) {
        throw const NetworkException(
          'Invalid categories response from server.',
        );
      }

      return data.map((item) {
        if (item is! String) {
          throw const NetworkException(
            'Invalid category item from server.',
          );
        }
        return item;
      }).toList();
    } on NetworkException {
      rethrow;
    } catch (_) {
      throw const NetworkException(
        'Something went wrong while loading categories.',
      );
    }
  }

  /// GET /products/category/{category}
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await _apiService.get(
        ApiConstants.productsByCategory(category),
      );
      final data = response.data;

      if (data is! List) {
        throw const NetworkException(
          'Invalid products response from server.',
        );
      }

      return data.map((item) {
        if (item is! Map<String, dynamic>) {
          throw const NetworkException(
            'Invalid product item from server.',
          );
        }
        return ProductModel.fromJson(item);
      }).toList();
    } on NetworkException {
      rethrow;
    } catch (_) {
      throw const NetworkException(
        'Something went wrong while loading category products.',
      );
    }
  }
}
