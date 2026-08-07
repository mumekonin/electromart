import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../category/presentation/providers/category_provider.dart';
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

/// Products after in-memory category filter + local title search.
///
/// Why local filtering?
/// - Fake Store API has NO search endpoint
/// - Category chips should not re-fetch the network (keeps Home smooth)
/// - [productProvider] already holds the full electronics list
///
/// Flow:
/// 1. [productProvider] loads all electronics once
/// 2. Optional category chip filters by keywords
/// 3. Optional search query filters by title
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsState = ref.watch(productProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  // Keep loading / error from product loading — filters never fail.
  return productsState.whenData((products) {
    var result = products;

    // Department chip (null = All).
    if (selectedCategory != null) {
      result = result.where(selectedCategory.matchesProduct).toList();
    }

    // Title search.
    if (query.isNotEmpty) {
      result = result
          .where((product) => product.title.toLowerCase().contains(query))
          .toList();
    }

    return result;
  });
});
