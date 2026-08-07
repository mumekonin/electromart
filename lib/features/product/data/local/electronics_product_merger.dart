import '../../../../core/network/api_constants.dart';
import '../../domain/entities/product.dart';
import '../mappers/product_mapper.dart';
import '../models/product_model.dart';
import 'local_electronics_catalog.dart';

/// Combines Fake Store electronics with the local catalog.
///
/// Why this helper exists:
/// - Product listing and Category browsing need the same merge rules
/// - Avoids duplicating “filter electronics + append local items” in two repos
class ElectronicsProductMerger {
  ElectronicsProductMerger._();

  /// From a full Fake Store product list (mixed categories).
  static List<Product> fromAllProducts(List<ProductModel> models) {
    final apiElectronics = models
        .where(
          (model) => ApiConstants.isElectronicsCategory(model.category),
        )
        .map(ProductMapper.toEntity);

    return combineWithLocal(apiElectronics);
  }

  /// From Fake Store `/products/category/electronics` (already electronics).
  static List<Product> fromElectronicsModels(List<ProductModel> models) {
    final apiProducts = models.map(ProductMapper.toEntity);
    return combineWithLocal(apiProducts);
  }

  /// Appends [LocalElectronicsCatalog] after API products.
  static List<Product> combineWithLocal(Iterable<Product> apiProducts) {
    return [
      ...apiProducts,
      ...LocalElectronicsCatalog.products,
    ];
  }
}
