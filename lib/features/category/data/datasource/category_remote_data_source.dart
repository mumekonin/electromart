import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/network_exception.dart';
import '../../../product/data/models/product_model.dart';

/// Talks to Fake Store category product endpoints.
///
/// Why this class exists:
/// - Isolates category HTTP calls from the repository
/// - Reuses [ProductModel] for products-by-category responses
/// - Uses the shared [ApiService]
///
/// Note: Fake Store category *names* are not used for ElectroMart chips.
/// Chips come from [ElectronicsCatalog]; this data source only loads products.
class CategoryRemoteDataSource {
  CategoryRemoteDataSource(this._apiService);

  final ApiService _apiService;

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
