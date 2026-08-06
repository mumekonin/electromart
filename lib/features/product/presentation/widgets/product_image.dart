import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// Large hero-style product image for Product Details.
///
/// Why this widget exists:
/// - Reuses CachedNetworkImage loading / error handling
/// - Keeps rounded electronics-store imagery in one place
class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320.h,
      decoration: BoxDecoration(
        color: AppColors.surfaceOf(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderOf(context)),
      ),
      clipBehavior: Clip.antiAlias,
      child: ColoredBox(
        color: const Color(0xFFF1F5F9),
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
    );
  }
}
