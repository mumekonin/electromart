import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../providers/search_provider.dart';

/// Rounded Material 3 search field for Home.
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
      child: Material(
        color: AppColors.surfaceOf(context),
        elevation: 0,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).updateQuery(value);
          },
          textInputAction: TextInputAction.search,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Search electronics…',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondaryOf(context),
                ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.primary,
            ),
            suffixIcon: hasText
                ? IconButton(
                    tooltip: 'Clear search',
                    onPressed: _clear,
                    icon: Icon(
                      Icons.cancel_rounded,
                      color: AppColors.textSecondaryOf(context),
                    ),
                  )
                : null,
            filled: true,
            fillColor: AppColors.surfaceOf(context),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              borderSide: BorderSide(color: AppColors.borderOf(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              borderSide: BorderSide(color: AppColors.borderOf(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
