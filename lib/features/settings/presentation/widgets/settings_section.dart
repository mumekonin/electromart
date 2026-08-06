import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

/// A titled rounded card that groups related settings tiles.
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppSpacing.xs),
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondaryOf(context),
            ),
          ),
        ),
        Gap(AppSpacing.sm),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceOf(context),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(color: AppColors.borderOf(context)),
          ),
          child: Column(
            children: _withDividers(children),
          ),
        ),
      ],
    );
  }

  List<Widget> _withDividers(List<Widget> tiles) {
    if (tiles.isEmpty) return tiles;

    final result = <Widget>[];
    for (var i = 0; i < tiles.length; i++) {
      result.add(tiles[i]);
      if (i < tiles.length - 1) {
        result.add(const Divider(height: 1, indent: 56));
      }
    }
    return result;
  }
}
