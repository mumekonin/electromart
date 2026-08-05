import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/network_exception.dart';
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
/// - Loads products when Home opens
/// - Exposes [refresh] for pull-to-refresh and Retry
class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    // Called automatically the first time Home watches this provider.
    return ref.read(getAllProductsUseCaseProvider)();
  }

  /// Reloads products from the API.
  ///
  /// We do not force [AsyncLoading] here so pull-to-refresh can keep
  /// showing the old list while the new data loads.
  Future<void> refresh() async {
    state = await AsyncValue.guard(() {
      return ref.read(getAllProductsUseCaseProvider)();
    });
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
