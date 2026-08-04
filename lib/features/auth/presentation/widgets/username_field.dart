import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';

/// Rounded username text field for the login form.
///
/// Why this widget exists:
/// - Keeps the username input reusable and small
/// - Login form stays readable instead of one giant widget
class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      autofillHints: const [AutofillHints.username],
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Enter your username',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Username is required';
        }
        return null;
      },
    );
  }
}
