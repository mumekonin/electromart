import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_empty_state.dart';
import '../providers/search_provider.dart';

/// Shown when local search finds no matching products.
class SearchEmptyView extends ConsumerWidget {
  const SearchEmptyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppEmptyState(
      icon: Icons.search_off_rounded,
      title: 'No results found',
      description:
          'Try a different keyword, or clear the search to see all products again.',
      actionLabel: 'Clear search',
      actionIcon: Icons.clear_rounded,
      onAction: () {
        ref.read(searchQueryProvider.notifier).clear();
      },
    );
  }
}
