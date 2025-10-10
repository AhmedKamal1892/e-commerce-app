import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 48,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: Row(
              children: [
                Text('StyleShop', style: textTheme.displaySmall),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: AppColors.foreground,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Divider(thickness: 0.5, color: AppColors.mutedForeground),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text('Orders History', style: textTheme.bodyLarge),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text('Saved Items', style: textTheme.bodyLarge),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text('Addresses', style: textTheme.bodyLarge),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.payment_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text('Payment', style: textTheme.bodyLarge),
                  onTap: () {},
                ),
                const Divider(thickness: 0.5, color: AppColors.mutedForeground),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.help_outline,
                    color: AppColors.primary,
                  ),
                  title: Text('Help', style: textTheme.bodyLarge),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text('Settings', style: textTheme.bodyLarge),
                  onTap: () {},
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.call_outlined,
                    color: AppColors.primary,
                  ),
                  title: Text('Contact', style: textTheme.bodyLarge),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 0.5, color: AppColors.mutedForeground),
                const SizedBox(height: 16),
                Text(
                  'StyleShop v1.0.0',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
