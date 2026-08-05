import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_exception.dart';
import '../models/product_model.dart';

/// Talks to Fake Store Products API.
///
/// Why this class exists:
/// - Isolates HTTP product details from the repository
/// - Uses the shared [ApiService] (one Dio client for the whole app)
/// - Turns API JSON into a list of [ProductModel]
class ProductRemoteDataSource {
  ProductRemoteDataSource(this._apiService);

  final ApiService _apiService;

  /// GET /products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await _apiService.get(ApiConstants.products);
      final data = response.data;

      // Fake Store returns a JSON array of products.
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
        'Something went wrong while loading products.',
      );
    }
  }

  /// GET /products/{id}
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _apiService.get(ApiConstants.productById(id));
      final data = response.data;

      // Fake Store returns one JSON object for a single product.
      if (data is! Map<String, dynamic>) {
        throw const NetworkException(
          'Product not found.',
          statusCode: 404,
        );
      }

      return ProductModel.fromJson(data);
    } on NetworkException catch (exception) {
      if (exception.statusCode == 404) {
        throw const NetworkException(
          'Product not found.',
          statusCode: 404,
        );
      }
      rethrow;
    } catch (_) {
      throw const NetworkException(
        'Something went wrong while loading this product.',
      );
    }
  }
}
