import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_exception.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_details_usecase.dart';
import 'product_provider.dart';

/// Provides the get-product-details use case.
final getProductDetailsUseCaseProvider =
    Provider<GetProductDetailsUseCase>((ref) {
  return GetProductDetailsUseCase(ref.watch(productRepositoryProvider));
});

/// Loads one product by id for the Product Details screen.
///
/// Why this class exists:
/// - Separate from the Home list provider (one responsibility)
/// - Riverpod family = one provider instance per product id
/// - Exposes loading / success / error through [AsyncValue]
///
/// In Riverpod 3, the family argument is passed into the constructor.
class ProductDetailsNotifier extends AsyncNotifier<Product> {
  ProductDetailsNotifier(this.productId);

  /// The Fake Store product id from GoRouter (`/product/:id`).
  final int productId;

  @override
  Future<Product> build() {
    return ref.read(getProductDetailsUseCaseProvider)(productId);
  }

  /// Reloads the same product after an error.
  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(getProductDetailsUseCaseProvider)(productId);
    });
  }

  /// Friendly error text for the UI.
  static String errorMessage(Object error) {
    if (error is NetworkException) {
      return error.message;
    }
    return 'Something went wrong. Please try again.';
  }

  /// True when the API says the product does not exist.
  static bool isNotFound(Object error) {
    return error is NetworkException && error.statusCode == 404;
  }
}

/// Family provider: watch with `ref.watch(productDetailsProvider(productId))`.
final productDetailsProvider = AsyncNotifierProvider.family<
    ProductDetailsNotifier, Product, int>(ProductDetailsNotifier.new);
