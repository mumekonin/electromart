import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_data_source.dart';
import '../mappers/product_mapper.dart';

/// Concrete [ProductRepository] using the remote API.
///
/// Why this class exists:
/// - Implements the domain repository contract
/// - Maps [ProductModel] (data) → [Product] (domain)
/// - Presentation never calls Dio here directly
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await _remoteDataSource.getAllProducts();
    return models.map(ProductMapper.toEntity).toList();
  }

  @override
  Future<Product> getProductById(int id) async {
    final model = await _remoteDataSource.getProductById(id);
    return ProductMapper.toEntity(model);
  }
}
