import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/network/error_message.dart';
import '../../data/datasource/category_remote_data_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/get_categories_usecase.dart';

/// Provides the category remote data source.
final categoryRemoteDataSourceProvider =
    Provider<CategoryRemoteDataSource>((ref) {
  return CategoryRemoteDataSource(ref.watch(apiServiceProvider));
});

/// Provides the category repository implementation.
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(ref.watch(categoryRemoteDataSourceProvider));
});

/// Provides the get-categories use case.
final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  return GetCategoriesUseCase(ref.watch(categoryRepositoryProvider));
});

/// Loads ElectroMart electronics departments for the chip row.
///
/// Departments come from a static catalog (not Fake Store clothing names).
class CategoriesNotifier extends AsyncNotifier<List<Category>> {
  @override
  Future<List<Category>> build() {
    return ref.read(getCategoriesUseCaseProvider)();
  }

  /// Reloads categories after an error.
  Future<void> retry() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(getCategoriesUseCaseProvider)();
    });
  }

  static String errorMessage(Object error) {
    return mapErrorMessage(error);
  }
}

/// Provider for electronics department chips.
final categoriesProvider =
    AsyncNotifierProvider<CategoriesNotifier, List<Category>>(
  CategoriesNotifier.new,
);

/// Holds the currently selected category chip.
///
/// Why this class exists:
/// - Separate from "load categories" (one responsibility)
/// - `null` means the user selected **All** electronics products
/// - [filteredProductsProvider] watches this and filters in memory
class SelectedCategoryNotifier extends Notifier<Category?> {
  @override
  Category? build() => null;

  /// Select the "All" chip → show every electronics product.
  void selectAll() {
    state = null;
  }

  /// Select one electronics department → filter products.
  void select(Category category) {
    state = category;
  }
}

/// Provider for the selected category (`null` = All).
final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, Category?>(
  SelectedCategoryNotifier.new,
);
