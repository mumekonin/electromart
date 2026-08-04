import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_spacing.dart';
import '../providers/auth_provider.dart';
import 'login_button.dart';
import 'password_field.dart';
import 'username_field.dart';

/// Login form: username, password, and submit button.
///
/// Why this widget exists:
/// - Groups form state (controllers + validation) together
/// - [LoginPage] stays focused on layout and navigation side-effects
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Used to rebuild the button when text changes (empty → filled).
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_updateCanSubmit);
    _passwordController.addListener(_updateCanSubmit);
  }

  void _updateCanSubmit() {
    final canSubmit = _usernameController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty;

    if (canSubmit != _canSubmit) {
      setState(() {
        _canSubmit = canSubmit;
      });
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    await ref.read(authProvider.notifier).login(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  void dispose() {
    _usernameController
      ..removeListener(_updateCanSubmit)
      ..dispose();
    _passwordController
      ..removeListener(_updateCanSubmit)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.isLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UsernameField(
            controller: _usernameController,
            enabled: !isLoading,
          ),
          Gap(AppSpacing.md),
          PasswordField(
            controller: _passwordController,
            enabled: !isLoading,
            onSubmitted: _canSubmit && !isLoading ? _submit : null,
          ),
          Gap(AppSpacing.lg),
          LoginButton(
            onPressed: _submit,
            isLoading: isLoading,
            isEnabled: _canSubmit,
          ),
        ],
      ),
    );
  }
}
