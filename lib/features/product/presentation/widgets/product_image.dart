import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Large hero-style product image for Product Details.
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    // Slightly taller on large phones, still safe on small screens.
    final height = MediaQuery.sizeOf(context).height < 700 ? 260.h : 320.h;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderOf(context)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimaryOf(context).withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: ColoredBox(
        color: AppColors.backgroundOf(context),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2.5),
              );
            },
            errorWidget: (context, url, error) {
              return Icon(
                Icons.devices_other_outlined,
                size: 64.sp,
                color: AppColors.textSecondaryOf(context),
              );
            },
          ),
        ),
      ),
    );
  }
}
