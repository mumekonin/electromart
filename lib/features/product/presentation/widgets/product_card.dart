import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/fade_scale_in.dart';
import '../../domain/entities/product.dart';

/// One product tile in the Home grid.
///
/// Polish notes:
/// - Soft shadow + rounded corners for a storefront feel
/// - Shows rating stars from Fake Store data
/// - Clear price styling with brand color
class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.animationIndex = 0,
  });

  final Product product;

  /// Staggers the entrance animation slightly in a grid.
  final int animationIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final delayMs = (animationIndex % 6) * 40;

    return FadeScaleIn(
      delay: Duration(milliseconds: delayMs),
      child: Material(
        color: AppColors.surfaceOf(context),
        elevation: 0,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          onTap: () {
            context.push(AppRoutes.productDetailsPath(product.id));
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(color: AppColors.borderOf(context)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimaryOf(context).withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.radiusLarge),
                    ),
                    child: ColoredBox(
                      color: AppColors.backgroundOf(context),
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.sm),
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.contain,
                          placeholder: (context, url) {
                            return Center(
                              child: SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Icon(
                              Icons.devices_other_outlined,
                              size: 36.sp,
                              color: AppColors.textSecondaryOf(context),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      AppSpacing.xs,
                      AppSpacing.sm,
                      AppSpacing.sm,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall,
                        ),
                        Gap(AppSpacing.xs),
                        _RatingRow(
                          rate: product.rating.rate,
                          count: product.rating.count,
                        ),
                        const Spacer(),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact star + score for product cards.
class _RatingRow extends StatelessWidget {
  const _RatingRow({
    required this.rate,
    required this.count,
  });

  final double rate;
  final int count;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          size: 14.sp,
          color: AppColors.warning,
        ),
        Gap(AppSpacing.xs),
        Flexible(
          child: Text(
            '${rate.toStringAsFixed(1)} ($count)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondaryOf(context),
            ),
          ),
        ),
      ],
    );
  }
}
