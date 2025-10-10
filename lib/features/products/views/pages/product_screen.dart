import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 175,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                ),
                color: AppColors.accent,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingXL,
                    vertical: AppConstants.paddingL,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Special Offers',
                            style: theme.textTheme.displayMedium,
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              // Close the card
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.accentForeground,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Up to 50% off on selected items',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.accentForeground,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentForeground,
                          foregroundColor: AppColors.accent,
                        ),
                        child: Text(
                          'Shop Now',
                          style: theme.elevatedButtonTheme.style?.textStyle
                              ?.resolve({}),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
