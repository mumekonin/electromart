import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// Shared Material 3 app bar for ElectroMart screens.
///
/// Why this widget exists:
/// - Keeps title style and background consistent
/// - Optional actions (cart badge, clear, …) stay flexible
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actions,
      backgroundColor: AppColors.surfaceOf(context),
      foregroundColor: AppColors.textPrimaryOf(context),
      elevation: 0,
      scrolledUnderElevation: 0.5,
    );
  }
}
