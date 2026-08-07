import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/error_message.dart';
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

/// Loads every electronics product once (API + local catalog).
///
/// Why we do NOT watch the selected category here:
/// - Watching a category inside [build] reloads the whole list on every chip tap
/// - That flashed a full-page spinner on Home
/// - Category + search filtering stays in [filteredProductsProvider] (in memory)
class ProductNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    return ref.read(getAllProductsUseCaseProvider)();
  }

  /// Reloads products from the API (pull-to-refresh / Retry).
  Future<void> refresh() async {
    state = await AsyncValue.guard(() {
      return ref.read(getAllProductsUseCaseProvider)();
    });
  }

  /// Friendly error text for the UI.
  static String errorMessage(Object error) {
    return mapErrorMessage(error);
  }
}

/// Global products provider used by Home (via [filteredProductsProvider]).
final productProvider =
    AsyncNotifierProvider<ProductNotifier, List<Product>>(ProductNotifier.new);
