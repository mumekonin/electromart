import '../../../../core/network/api_constants.dart';
import '../../../../core/network/network_exception.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_data_source.dart';
import '../mappers/product_mapper.dart';

/// Concrete [ProductRepository] using the remote API.
///
/// Why this class exists:
/// - Implements the domain repository contract
/// - Maps [ProductModel] (data) → [Product] (domain)
/// - Keeps only electronics products for ElectroMart
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await _remoteDataSource.getAllProducts();

    // Fake Store mixes clothing / jewelry — ElectroMart sells electronics only.
    return models
        .where(
          (model) => ApiConstants.isElectronicsCategory(model.category),
        )
        .map(ProductMapper.toEntity)
        .toList();
  }

  @override
  Future<Product> getProductById(int id) async {
    final model = await _remoteDataSource.getProductById(id);

    // Block non-electronics product details pages.
    if (!ApiConstants.isElectronicsCategory(model.category)) {
      throw const NetworkException(
        'Product not found.',
        statusCode: 404,
      );
    }

    return ProductMapper.toEntity(model);
  }
}
