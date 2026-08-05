import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../providers/search_provider.dart';

/// Shown when the search query matches no product titles.
///
/// Why this widget exists:
/// - Different from "category has no products"
/// - Offers a one-tap Clear Search action
class SearchEmptyView extends ConsumerWidget {
  const SearchEmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final query = ref.watch(searchQueryProvider);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: AppColors.textSecondary,
            ),
            Gap(AppSpacing.md),
            Text(
              'No products found',
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.sm),
            Text(
              'We could not find anything matching "$query".\n'
              'Try another keyword or clear the search.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.lg),
            FilledButton.icon(
              onPressed: () {
                ref.read(searchQueryProvider.notifier).clear();
              },
              icon: const Icon(Icons.clear_rounded),
              label: const Text('Clear search'),
            ),
          ],
        ),
      ),
    );
  }
}
