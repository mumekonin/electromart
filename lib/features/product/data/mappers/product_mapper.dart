import '../../domain/entities/product.dart';
import '../models/product_model.dart';

/// Converts [ProductModel] (data) into [Product] (domain).
///
/// Why this class exists:
/// - Product Listing and Category both need the same mapping
/// - Avoids copy-pasting mapping code in two repositories
class ProductMapper {
  ProductMapper._();

  static Product toEntity(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      image: model.image,
      rating: ProductRating(
        rate: model.rating.rate,
        count: model.rating.count,
      ),
    );
  }
}
