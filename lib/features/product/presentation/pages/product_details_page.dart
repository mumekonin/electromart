import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../domain/entities/product.dart';
import '../providers/product_details_provider.dart';
import '../widgets/action_buttons.dart';
import '../widgets/category_badge.dart';
import '../widgets/description_section.dart';
import '../widgets/product_details_loading_view.dart';
import '../widgets/product_image.dart';
import '../widgets/product_not_found_view.dart';
import '../widgets/product_price.dart';
import '../widgets/products_error_view.dart';
import '../widgets/rating_section.dart';

/// Premium Product Details screen for ElectroMart.
///
/// Why this page exists:
/// - Shows full info for one product from GET /products/{id}
/// - Watches [productDetailsProvider] for loading / data / error
/// - Uses small widgets so the layout stays easy to read
class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  /// Product id from GoRouter (`/product/:id`).
  final int productId;

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  /// Favorite is UI-only for now (not saved).
  bool _isFavorite = false;

  void _showComingSoon(String featureName) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$featureName coming soon'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    // Invalid route id → treat as not found.
    if (widget.productId <= 0) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: const Text('Product Details'),
        ),
        body: const ProductNotFoundView(),
      );
    }

    final detailsState = ref.watch(productDetailsProvider(widget.productId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Product Details'),
        actions: [
          IconButton(
            tooltip: _isFavorite ? 'Remove favorite' : 'Add favorite',
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              _showComingSoon('Wishlist');
            },
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? AppColors.error : AppColors.textPrimary,
            ),
          ),
        ],
      ),
      body: detailsState.when(
        loading: () => const ProductDetailsLoadingView(),
        error: (error, _) {
          if (ProductDetailsNotifier.isNotFound(error)) {
            return const ProductNotFoundView();
          }

          return ProductsErrorView(
            message: ProductDetailsNotifier.errorMessage(error),
            onRetry: () {
              return ref
                  .read(productDetailsProvider(widget.productId).notifier)
                  .retry();
            },
          );
        },
        data: (product) => _ProductDetailsBody(
          product: product,
          // Integration: Add To Cart on Product Details.
          // Saves a CartItem snapshot via cartProvider (persists to SharedPreferences).
          onAddToCart: () async {
            final messenger = ScaffoldMessenger.of(context);

            try {
              await ref.read(cartProvider.notifier).addToCart(
                    CartItem(
                      productId: product.id,
                      title: product.title,
                      price: product.price,
                      image: product.image,
                      quantity: 1,
                    ),
                  );

              if (!mounted) return;

              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text('Added to cart'),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.success,
                  ),
                );
            } catch (error) {
              if (!mounted) return;

              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(cartErrorMessage(error)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.error,
                  ),
                );
            }
          },
          onBuyNow: () => _showComingSoon('Checkout'),
        ),
      ),
    );
  }
}

/// Scrollable success content + bottom action bar.
class _ProductDetailsBody extends StatelessWidget {
  const _ProductDetailsBody({
    required this.product,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImage(imageUrl: product.image),
                Gap(AppSpacing.lg),
                CategoryBadge(category: product.category),
                Gap(AppSpacing.sm),
                Text(
                  product.title,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(AppSpacing.md),
                ProductPrice(price: product.price),
                Gap(AppSpacing.sm),
                RatingSection(rating: product.rating),
                Gap(AppSpacing.lg),
                Divider(color: AppColors.border),
                Gap(AppSpacing.md),
                DescriptionSection(description: product.description),
                Gap(AppSpacing.xl),
              ],
            ),
          ),
        ),
        ActionButtons(
          onAddToCart: onAddToCart,
          onBuyNow: onBuyNow,
        ),
      ],
    );
  }
}
