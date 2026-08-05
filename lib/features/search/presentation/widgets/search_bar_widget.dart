import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../providers/search_provider.dart';

/// Rounded Material 3 search field for Home.
///
/// Why this widget exists:
/// - Reusable search UI (icon, hint, clear button)
/// - Talks to [searchQueryProvider] so typing updates results live
class SearchBarWidget extends ConsumerStatefulWidget {
  const SearchBarWidget({super.key});

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(searchQueryProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    // If search is cleared from another widget (empty state button),
    // keep the text field in sync.
    ref.listen<String>(searchQueryProvider, (previous, next) {
      if (next.isEmpty && _controller.text.isNotEmpty) {
        _controller.clear();
      }
    });

    final hasText = ref.watch(searchQueryProvider).isNotEmpty;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).updateQuery(value);
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search electronics...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: hasText
              ? IconButton(
                  tooltip: 'Clear search',
                  onPressed: _clear,
                  icon: const Icon(Icons.close_rounded),
                )
              : null,
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
