import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';

/// Prominent product price for Product Details.
///
/// Why this widget exists:
/// - Price is a key shopping signal — keep its style consistent
class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: textTheme.headlineMedium?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
        fontSize: 28.sp,
      ),
    );
  }
}
