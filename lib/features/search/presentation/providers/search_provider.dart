import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/entities/product.dart';
import '../../../product/presentation/providers/product_provider.dart';

/// Stores the current search text typed by the user.
///
/// Why this class exists:
/// - One provider = one responsibility (the search query only)
/// - Does NOT call the API (Fake Store has no search endpoint)
/// - Does NOT change [productProvider] — original list stays intact
class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  /// Called on every keystroke for real-time search.
  void updateQuery(String value) {
    state = value;
  }

  /// Clears the query (empty search = show category products again).
  void clear() {
    state = '';
  }
}

/// Provider for the raw search query string.
final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

/// Products after category load + local title search.
///
/// Why local filtering?
/// - Fake Store API has NO search endpoint
/// - Calling the server on every keystroke would be slow and wasteful
/// - [productProvider] already has the current category products in memory
///
/// Flow:
/// 1. [productProvider] loads products for the selected category
/// 2. This provider filters those products by title (case-insensitive)
/// 3. Empty query → returns the category list unchanged
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsState = ref.watch(productProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  // Keep loading / error from product loading — search itself never fails.
  return productsState.whenData((products) {
    if (query.isEmpty) {
      return products;
    }

    return products
        .where((product) => product.title.toLowerCase().contains(query))
        .toList();
  });
});
