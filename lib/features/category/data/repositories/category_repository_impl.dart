import '../../../product/data/mappers/product_mapper.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasource/category_remote_data_source.dart';

/// Concrete [CategoryRepository] using the remote API.
///
/// Why this class exists:
/// - Implements the domain category contract
/// - Converts API strings → [Category] entities
/// - Reuses [ProductMapper] so product mapping stays in one place
class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._remoteDataSource);

  final CategoryRemoteDataSource _remoteDataSource;

  @override
  Future<List<Category>> getCategories() async {
    final names = await _remoteDataSource.getCategories();
    return names.map((name) => Category(name: name)).toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryName) async {
    final models = await _remoteDataSource.getProductsByCategory(categoryName);
    return models.map(ProductMapper.toEntity).toList();
  }
}
