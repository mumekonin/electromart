import '../../../../core/network/api_constants.dart';
import '../../../product/data/mappers/product_mapper.dart';
import '../../../product/domain/entities/product.dart';
import '../../domain/electronics_catalog.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasource/category_remote_data_source.dart';

/// Concrete [CategoryRepository] for ElectroMart departments.
///
/// Why this class exists:
/// - Exposes Laptops / TVs / AirPods / ... chips
/// - Loads real Fake Store electronics products
/// - Filters those products into a department with keywords
class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._remoteDataSource);

  final CategoryRemoteDataSource _remoteDataSource;

  @override
  Future<List<Category>> getCategories() async {
    // Departments come from our electronics catalog (not Fake Store clothing).
    return List<Category>.from(ElectronicsCatalog.categories);
  }

  @override
  Future<List<Product>> getProductsByCategory(String categoryName) async {
    final category = ElectronicsCatalog.findByName(categoryName);
    if (category == null) {
      return [];
    }

    // Always load Fake Store electronics, then filter by department keywords.
    final models = await _remoteDataSource.getProductsByCategory(
      ApiConstants.electronicsCategory,
    );

    return models
        .map(ProductMapper.toEntity)
        .where(category.matchesProduct)
        .toList();
  }
}
