import '../../../../core/network/api_constants.dart';
import '../../../product/data/local/local_electronics_catalog.dart';
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
/// - Loads Fake Store electronics + local catalog products
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

    // 1) Fake Store electronics
    final models = await _remoteDataSource.getProductsByCategory(
      ApiConstants.electronicsCategory,
    );

    final apiProducts = models.map(ProductMapper.toEntity);

    // 2) Local electronics (laptops, phones, TVs, …)
    final localProducts = LocalElectronicsCatalog.products;

    // 3) Keep only products that match this department's keywords.
    return [
      ...apiProducts,
      ...localProducts,
    ].where(category.matchesProduct).toList();
  }
}
