import 'package:flutter/material.dart';

/// Temporary Product Details screen.
///
/// Why this page exists:
/// - Product cards need a GoRouter destination when tapped
/// - Full Product Details UI will be built in a later module
/// - Keep this intentionally minimal for now
class ProductDetailsPlaceholderPage extends StatelessWidget {
  const ProductDetailsPlaceholderPage({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Center(
        child: Text(
          'Product #$productId\nDetails coming soon',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
