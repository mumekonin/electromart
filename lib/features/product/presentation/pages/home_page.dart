import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../category/presentation/providers/category_provider.dart';
import '../../../category/presentation/widgets/category_chip_bar.dart';
import '../../../search/presentation/providers/search_provider.dart';
import '../../../search/presentation/widgets/search_bar_widget.dart';
import '../../../search/presentation/widgets/search_empty_view.dart';
import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/products_empty_view.dart';
import '../widgets/products_error_view.dart';

/// Home screen: search + category chips + product grid.
///
/// Why this page exists:
/// - Main shopping entry after login
/// - Search filters products already loaded for the selected category
/// - Watches loading / error from [productProvider] (not from search)
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(filteredProductsProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final hasSearchQuery = searchQuery.trim().isNotEmpty;

    // Integration: cart badge on Product Listing (Home).
    // Shows how many units are in the cart; tap opens Cart page.
    final cartTotalItems = ref.watch(cartTotalItemsProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundOf(context),
      appBar: AppBar(
        title: const Text('ElectroMart'),
        actions: [
          // Quick jump to Cart tab (bottom nav also has Cart).
          IconButton(
            tooltip: 'Cart',
            onPressed: () => context.go(AppRoutes.cart),
            icon: Badge(
              isLabelVisible: cartTotalItems > 0,
              label: Text('$cartTotalItems'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Local search (no API calls on each keystroke).
          const SearchBarWidget(),

          // Electronics department chips.
          const CategoryChipBar(),
          Divider(height: 1, color: AppColors.borderOf(context)),

          // Product grid / loading / error / empty.
          Expanded(
            child: productsState.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) {
                return ProductsErrorView(
                  message: ProductNotifier.errorMessage(error),
                  onRetry: () => ref.read(productProvider.notifier).refresh(),
                );
              },
              data: (products) {
                if (products.isEmpty && hasSearchQuery) {
                  return const SearchEmptyView();
                }

                if (products.isEmpty) {
                  final categoryLabel =
                      selectedCategory?.displayName ?? 'All Products';

                  return ProductsEmptyView(
                    onRefresh: () =>
                        ref.read(productProvider.notifier).refresh(),
                    message:
                        'No products found in $categoryLabel. Try another category.',
                  );
                }

                return _ProductsGrid(
                  products: products,
                  onRefresh: () =>
                      ref.read(productProvider.notifier).refresh(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Responsive product grid with pull-to-refresh.
class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({
    required this.products,
    required this.onRefresh,
  });

  final List<Product> products;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth >= 600 ? 3 : 2;

        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: onRefresh,
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(AppSpacing.md),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.68,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          ),
        );
      },
    );
  }
}
