import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/theme/app_colors.dart';

/// Circular avatar that shows the user's initials.
///
/// Fake Store does not provide a profile photo URL, so we build
/// a clean initials avatar from the full name instead.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.fullName,
    this.size,
    super.key,
  });

  final String fullName;

  /// Diameter of the circle. Defaults to a large profile size.
  final double? size;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final diameter = size ?? 96.w;
    final initials = _initialsFromName(fullName);

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        color: AppColors.primarySoftOf(context),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderOf(context), width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: textTheme.headlineMedium?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
          fontSize: diameter * 0.32,
        ),
      ),
    );
  }

  /// Takes "John Doe" → "JD". Falls back to "?" when empty.
  String _initialsFromName(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return '?';
    }

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    final first = parts.first.substring(0, 1);
    final last = parts.last.substring(0, 1);
    return (first + last).toUpperCase();
  }
}
