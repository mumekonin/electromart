import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/product.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/products_empty_view.dart';
import '../widgets/products_error_view.dart';

/// Home screen that lists all Fake Store products.
///
/// Why this page exists:
/// - Main shopping entry after login
/// - Watches [productProvider] for loading / data / error
/// - Shows a responsive product grid with pull-to-refresh
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('ElectroMart'),
      ),
      body: productsState.when(
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
          if (products.isEmpty) {
            return ProductsEmptyView(
              onRefresh: () => ref.read(productProvider.notifier).refresh(),
            );
          }

          return _ProductsGrid(
            products: products,
            onRefresh: () => ref.read(productProvider.notifier).refresh(),
          );
        },
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
        // More columns on wider screens (tablet / landscape).
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
              // Taller cards so title + price fit comfortably.
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
