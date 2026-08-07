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
// Busy flag (prevents overlapping cart writes)
// ---------------------------------------------------------------------------

/// True while a cart save is running.
///
/// Cart tiles disable +/- while this is true so rapid taps cannot
/// interleave load → modify → save and lose quantity updates.
class CartBusyNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setBusy(bool value) {
    state = value;
  }
}

final cartBusyProvider =
    NotifierProvider<CartBusyNotifier, bool>(CartBusyNotifier.new);

// ---------------------------------------------------------------------------
// Cart state (AsyncNotifier)
// ---------------------------------------------------------------------------

/// Manages shopping cart state with Riverpod [AsyncNotifier].
///
/// Why this class exists:
/// - One provider for cart (loading / success / error)
/// - UI calls methods like [addToCart] — never SharedPreferences
/// - Mutations run one after another (no overlapping writes)
class CartNotifier extends AsyncNotifier<Cart> {
  /// Chains cart writes so the second tap waits for the first to finish.
  Future<void> _writeQueue = Future<void>.value();

  /// Loads the cart when [cartProvider] is first watched (app start).
  @override
  Future<Cart> build() {
    return ref.read(getCartUseCaseProvider)();
  }

  /// Full reload with a loading state (used by Retry on the cart page).
  Future<void> loadCart() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(getCartUseCaseProvider)();
    });
  }

  /// Adds a product. Duplicates increase quantity on the same row.
  Future<void> addToCart(CartItem item) async {
    await _updateCart(() {
      return ref.read(addToCartUseCaseProvider)(item);
    });
  }

  /// Removes one product line completely.
  Future<void> removeFromCart(int productId) async {
    await _updateCart(() {
      return ref.read(removeFromCartUseCaseProvider)(productId);
    });
  }

  /// Increases quantity by 1.
  Future<void> increaseQuantity(int productId) async {
    await _updateCart(() {
      return ref.read(increaseQuantityUseCaseProvider)(productId);
    });
  }

  /// Decreases quantity by 1 (removes the row at 0 — never goes negative).
  Future<void> decreaseQuantity(int productId) async {
    await _updateCart(() {
      return ref.read(decreaseQuantityUseCaseProvider)(productId);
    });
  }

  /// Clears every item from the cart.
  Future<void> clearCart() async {
    await _updateCart(() {
      return ref.read(clearCartUseCaseProvider)();
    });
  }

  /// Runs a cart change and updates [state].
  ///
  /// Writes are queued so two taps cannot corrupt SharedPreferences.
  /// On failure we keep the previous cart on screen when possible,
  /// then rethrow so the UI can show a friendly SnackBar.
  Future<void> _updateCart(Future<Cart> Function() action) {
    final run = _writeQueue.then((_) => _runCartWrite(action));
    // Keep the chain alive even if one write fails.
    _writeQueue = run.catchError((_) {});
    return run;
  }

  Future<void> _runCartWrite(Future<Cart> Function() action) async {
    final previousCart = state.asData?.value;
    ref.read(cartBusyProvider.notifier).setBusy(true);

    try {
      final cart = await action();
      state = AsyncData(cart);
    } catch (error, stackTrace) {
      if (previousCart != null) {
        state = AsyncData(previousCart);
      } else {
        state = AsyncError(error, stackTrace);
      }
      rethrow;
    } finally {
      ref.read(cartBusyProvider.notifier).setBusy(false);
    }
  }

  /// Friendly message for cart UI / SnackBars.
  static String errorMessage(Object error) {
    final text = error.toString().toLowerCase();

    if (text.contains('sharedpreferences') || text.contains('prefs')) {
      return 'Could not save your cart on this device. Please try again.';
    }

    return 'Something went wrong with your cart. Please try again.';
  }
}

/// Top-level helper so widgets can call [cartErrorMessage] easily.
String cartErrorMessage(Object error) => CartNotifier.errorMessage(error);

/// Main cart provider used by Cart page and Add to Cart buttons.
final cartProvider =
    AsyncNotifierProvider<CartNotifier, Cart>(CartNotifier.new);

// ---------------------------------------------------------------------------
// Convenient read-only values for the UI
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
