import '../entities/category.dart';
import '../repositories/category_repository.dart';

/// Runs the "get all categories" business action.
///
/// Why this class exists:
/// - Presentation asks for categories through this use case
/// - Keeps Home free of repository / networking details
class GetCategoriesUseCase {
  GetCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  Future<List<Category>> call() {
    return _repository.getCategories();
  }
}
