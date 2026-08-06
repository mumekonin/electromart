import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../providers/category_provider.dart';
import 'category_chip.dart';

/// Horizontal electronics department chips above the product grid.
///
/// Why this widget exists:
/// - Shows All + Laptops / TVs / AirPods / Smartwatches / ...
/// - Updates [selectedCategoryProvider] when a chip is tapped
/// - Keeps Home focused on the product grid layout
class CategoryChipBar extends ConsumerWidget {
  const CategoryChipBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesState = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Container(
      width: double.infinity,
      color: AppColors.surfaceOf(context),
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: categoriesState.when(
        loading: () => SizedBox(
          height: 44.h,
          child: const Center(
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
        error: (error, _) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    CategoriesNotifier.errorMessage(error),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gap(AppSpacing.sm),
                TextButton(
                  onPressed: () {
                    ref.read(categoriesProvider.notifier).retry();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (categories) {
          if (categories.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'No categories available right now.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondaryOf(context),
                    ),
              ),
            );
          }

          return SizedBox(
            height: 44.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                // Always first: show every electronics product.
                CategoryChip(
                  label: 'All',
                  isSelected: selectedCategory == null,
                  onTap: () {
                    ref.read(selectedCategoryProvider.notifier).selectAll();
                  },
                ),
                // ElectroMart electronics departments.
                ...categories.map((category) {
                  return CategoryChip(
                    label: category.displayName,
                    isSelected: selectedCategory == category,
                    onTap: () {
                      ref
                          .read(selectedCategoryProvider.notifier)
                          .select(category);
                    },
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
