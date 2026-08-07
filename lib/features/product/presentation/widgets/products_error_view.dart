import 'package:flutter/material.dart';

import '../../../../core/widgets/app_error.dart';

/// Home / details error state — thin wrapper over [AppError].
class ProductsErrorView extends StatelessWidget {
  const ProductsErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return AppError(
      title: 'Could not load products',
      message: message,
      onRetry: () {
        onRetry();
      },
    );
  }
}
