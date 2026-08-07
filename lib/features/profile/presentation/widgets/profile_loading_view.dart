import 'package:flutter/material.dart';

import '../../../../core/widgets/app_loading.dart';

/// Shown while GET /users/{id} is in progress.
class ProfileLoadingView extends StatelessWidget {
  const ProfileLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLoading(message: 'Loading your profile…');
  }
}
