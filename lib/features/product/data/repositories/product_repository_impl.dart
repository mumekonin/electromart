import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/product_remote_data_source.dart';
import '../models/product_model.dart';

/// Concrete [ProductRepository] using the remote API.
///
/// Why this class exists:
/// - Implements the domain repository contract
/// - Maps [ProductModel] (data) → [Product] (domain)
/// - Presentation never calls Dio here directly
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getAllProducts() async {
    final models = await _remoteDataSource.getAllProducts();
    return models.map(_mapToEntity).toList();
  }

  /// Converts one API model into a domain entity.
  Product _mapToEntity(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      image: model.image,
      rating: ProductRating(
        rate: model.rating.rate,
        count: model.rating.count,
      ),
    );
  }
}
