import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/network_exception.dart';
import '../../../category/presentation/providers/category_provider.dart';
import '../../data/datasource/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_all_products_usecase.dart';

/// Provides the product remote data source.
final productRemoteDataSourceProvider =
    Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSource(ref.watch(apiServiceProvider));
});

/// Provides the product repository implementation.
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    ref.watch(productRemoteDataSourceProvider),
  );
});

/// Provides the get-all-products use case.
final getAllProductsUseCaseProvider = Provider<GetAllProductsUseCase>((ref) {
  return GetAllProductsUseCase(ref.watch(productRepositoryProvider));
});

/// Manages the product list with Riverpod [AsyncNotifier].
///
/// Why this class exists:
/// - One provider for products (loading / success / error)
/// - Watches [selectedCategoryProvider]
/// - Reloads automatically when the user changes category chips
class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    // When the selected category changes, Riverpod re-runs build().
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return _loadProducts(selectedCategory?.name);
  }

  /// Reloads products for the current category (or all products).
  Future<void> refresh() async {
    final selectedCategory = ref.read(selectedCategoryProvider);
    state = await AsyncValue.guard(() {
      return _loadProducts(selectedCategory?.name);
    });
  }

  /// "All" → get every product.
  /// Named category → get products for that category only.
  Future<List<Product>> _loadProducts(String? categoryName) {
    if (categoryName == null) {
      return ref.read(getAllProductsUseCaseProvider)();
    }

    return ref.read(getProductsByCategoryUseCaseProvider)(categoryName);
  }

  /// Friendly error text for the UI.
  static String errorMessage(Object error) {
    if (error is NetworkException) {
      return error.message;
    }
    return 'Something went wrong. Please try again.';
  }
}

/// Global products provider used by [HomePage].
final productProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(ProductNotifier.new);
