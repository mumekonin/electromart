import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/about_header.dart';
import '../widgets/info_section.dart';
import '../widgets/technology_card.dart';

/// About ElectroMart — static information screen.
///
/// Why About does NOT need Clean Architecture layers:
/// - Everything on this page is fixed text and icons
/// - There is no About API, no repository, and no use case
/// - Adding data/domain folders would only make beginners confused
///
/// Opened from: Profile → Settings → About ElectroMart
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.backgroundOf(context),
      appBar: const CustomAppBar(
        title: 'About ElectroMart',
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md),
        children: [
          Gap(AppSpacing.sm),
          const AboutHeader(),
          Gap(AppSpacing.xl),

          // --- What ElectroMart is ---
          InfoSection(
            title: 'About the app',
            child: Text(
              'ElectroMart is a modern electronics shopping application that '
              'allows users to browse products, search items, manage their '
              'shopping cart, and enjoy a simple shopping experience.',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryOf(context),
                height: 1.5,
              ),
            ),
          ),
          Gap(AppSpacing.md),

          // --- Application information ---
          InfoSection(
            title: 'Application information',
            child: Column(
              children: [
                const InfoRow(label: 'App Version', value: '1.0.0'),
                Gap(AppSpacing.sm),
                const InfoRow(label: 'API', value: 'Fake Store API'),
              ],
            ),
          ),
          Gap(AppSpacing.md),

          // --- Technologies ---
          InfoSection(
            title: 'Technologies',
            child: Column(
              children: [
                const TechnologyCard(
                  icon: Icons.flutter_dash,
                  name: 'Flutter',
                  description: 'UI toolkit used to build the mobile app.',
                ),
                Gap(AppSpacing.sm),
                const TechnologyCard(
                  icon: Icons.account_tree_outlined,
                  name: 'Riverpod',
                  description: 'State management for auth, cart, and products.',
                ),
                Gap(AppSpacing.sm),
                const TechnologyCard(
                  icon: Icons.cloud_outlined,
                  name: 'Dio',
                  description: 'HTTP client for Fake Store API requests.',
                ),
                Gap(AppSpacing.sm),
                const TechnologyCard(
                  icon: Icons.route_outlined,
                  name: 'GoRouter',
                  description: 'Navigation, splash redirects, and bottom tabs.',
                ),
                Gap(AppSpacing.sm),
                const TechnologyCard(
                  icon: Icons.storage_outlined,
                  name: 'SharedPreferences',
                  description: 'Local storage for login session and cart.',
                ),
                Gap(AppSpacing.sm),
                const TechnologyCard(
                  icon: Icons.storefront_outlined,
                  name: 'Fake Store API',
                  description: 'Demo backend for products, login, and users.',
                ),
              ],
            ),
          ),
          Gap(AppSpacing.xl),
        ],
      ),
    );
  }
}
