import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/storage_provider.dart';
import '../../data/datasource/cart_local_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/decrease_quantity_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/increase_quantity_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';

// ---------------------------------------------------------------------------
// Dependency injection (Riverpod providers)
// ---------------------------------------------------------------------------

/// Provides the local cart data source (SharedPreferences JSON).
final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref) {
  return CartLocalDataSource(ref.watch(sharedPreferencesProvider));
});

/// Provides the cart repository implementation.
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl(ref.watch(cartLocalDataSourceProvider));
});

final getCartUseCaseProvider = Provider<GetCartUseCase>((ref) {
  return GetCartUseCase(ref.watch(cartRepositoryProvider));
});

final addToCartUseCaseProvider = Provider<AddToCartUseCase>((ref) {
  return AddToCartUseCase(ref.watch(cartRepositoryProvider));
});

final removeFromCartUseCaseProvider = Provider<RemoveFromCartUseCase>((ref) {
  return RemoveFromCartUseCase(ref.watch(cartRepositoryProvider));
});

final increaseQuantityUseCaseProvider =
    Provider<IncreaseQuantityUseCase>((ref) {
  return IncreaseQuantityUseCase(ref.watch(cartRepositoryProvider));
});

final decreaseQuantityUseCaseProvider =
    Provider<DecreaseQuantityUseCase>((ref) {
  return DecreaseQuantityUseCase(ref.watch(cartRepositoryProvider));
});

final clearCartUseCaseProvider = Provider<ClearCartUseCase>((ref) {
  return ClearCartUseCase(ref.watch(cartRepositoryProvider));
});

// ---------------------------------------------------------------------------
// Cart state (AsyncNotifier)
// ---------------------------------------------------------------------------

/// Manages shopping cart state with Riverpod [AsyncNotifier].
///
/// Why this class exists:
/// - One provider for cart (loading / success / error)
/// - UI will call methods like [addToCart] — not SharedPreferences
/// - Every use case already saves the cart as JSON locally
///
/// State type is [Cart], which includes:
/// - items
/// - subtotal
/// - totalQuantity
class CartNotifier extends AsyncNotifier<Cart> {
  /// Called the first time something watches [cartProvider].
  ///
  /// Loads the cart from SharedPreferences so items restore on app start.
  @override
  Future<Cart> build() {
    return ref.read(getCartUseCaseProvider)();
  }

  /// Reloads the cart from SharedPreferences.
  ///
  /// Useful after login / app resume, or if you want a manual refresh.
  Future<void> loadCart() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(getCartUseCaseProvider)();
    });
  }

  /// Adds a product line to the cart.
  ///
  /// If the product is already there, quantity increases by 1.
  /// The repository saves the updated cart to SharedPreferences.
  Future<void> addToCart(CartItem item) async {
    state = await AsyncValue.guard(() {
      return ref.read(addToCartUseCaseProvider)(item);
    });
  }

  /// Removes one product completely (all of its quantity).
  Future<void> removeFromCart(int productId) async {
    state = await AsyncValue.guard(() {
      return ref.read(removeFromCartUseCaseProvider)(productId);
    });
  }

  /// Increases quantity of one product by 1, then saves.
  Future<void> increaseQuantity(int productId) async {
    state = await AsyncValue.guard(() {
      return ref.read(increaseQuantityUseCaseProvider)(productId);
    });
  }

  /// Decreases quantity of one product by 1, then saves.
  ///
  /// If quantity reaches 0, the item is removed from the cart.
  Future<void> decreaseQuantity(int productId) async {
    state = await AsyncValue.guard(() {
      return ref.read(decreaseQuantityUseCaseProvider)(productId);
    });
  }

  /// Removes every item and clears SharedPreferences cart JSON.
  Future<void> clearCart() async {
    state = await AsyncValue.guard(() {
      return ref.read(clearCartUseCaseProvider)();
    });
  }
}

/// Main cart provider used by future Cart UI / Add to Cart buttons.
final cartProvider =
    AsyncNotifierProvider<CartNotifier, Cart>(CartNotifier.new);

// ---------------------------------------------------------------------------
// Convenient read-only values for the UI (later)
// ---------------------------------------------------------------------------

/// List of cart lines. Empty list while loading or on error.
final cartItemsProvider = Provider<List<CartItem>>((ref) {
  final cart = ref.watch(cartProvider).value;
  return cart?.items ?? [];
});

/// Money total for all items (price × quantity).
final cartSubtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider).value;
  return cart?.subtotal ?? 0;
});

/// Total number of units in the cart (badge count).
final cartTotalItemsProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider).value;
  return cart?.totalQuantity ?? 0;
});
