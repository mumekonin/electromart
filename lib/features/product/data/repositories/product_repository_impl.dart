import '../../../../core/network/api_constants.dart';
import '../../../../core/network/network_exception.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_data_source.dart';
import '../local/electronics_product_merger.dart';
import '../local/local_electronics_catalog.dart';
import '../mappers/product_mapper.dart';

/// Concrete [ProductRepository] using the remote API + local catalog.
///
/// Why this class exists:
/// - Implements the domain repository contract
/// - Maps API models → domain [Product]
/// - Merges Fake Store electronics with [LocalElectronicsCatalog]
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await _remoteDataSource.getAllProducts();
    return ElectronicsProductMerger.fromAllProducts(models);
  }

  @override
  Future<Product> getProductById(int id) async {
    // Local catalog products are not on Fake Store — return them directly.
    final localProduct = LocalElectronicsCatalog.findById(id);
    if (localProduct != null) {
      return localProduct;
    }

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
