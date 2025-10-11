import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../models/product_model.dart';
import '../widgets/featured_products.dart';
import '../widgets/product_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> recommendedProducts = [
      ProductModel(
        id: '1',
        name: 'Premium T-Shirt',
        imageUrl: 'url1',
        price: 29.99,
        rating: 4.8,
        description: '',
        category: '',
      ),
      ProductModel(
        id: '2',
        name: 'Classic Sneaker',
        imageUrl: 'url2',
        price: 89.99,
        rating: 4.6,
        description: '',
        category: '',
      ),
      ProductModel(
        id: '5',
        name: 'Leather Boots',
        imageUrl: 'url5',
        price: 120.00,
        rating: 4.9,
        description: '',
        category: '',
      ),
      ProductModel(
        id: '6',
        name: 'Casual Hat',
        imageUrl: 'url6',
        price: 25.50,
        rating: 4.3,
        description: '',
        category: '',
      ),
    ];

    final List<ProductModel> onSaleProducts = [
      ProductModel(
        id: '3',
        name: 'Summer Dress',
        imageUrl: 'url3',
        price: 49.99,
        rating: 4.5,
        description: '',
        category: '',
      ),
      ProductModel(
        id: '4',
        name: 'Men\'s Jacket',
        imageUrl: 'url4',
        price: 115.20,
        rating: 4.7,
        description: '',
        category: '',
      ),
      ProductModel(
        id: '7',
        name: 'Sports Watch',
        imageUrl: 'url7',
        price: 199.99,
        rating: 4.4,
        description: '',
        category: '',
      ),
      ProductModel(
        id: '8',
        name: 'Running Shoes',
        imageUrl: 'url8',
        price: 75.00,
        rating: 4.6,
        description: '',
        category: '',
      ),
    ];
    final List<ProductModel> featuredProducts = [
      ProductModel(
        id: '8',
        name: 'Luxury Watch',
        description: 'desc',
        imageUrl: 'https://via.placeholder.com/150',
        price: 250.00,
        rating: 4.9,
        category: 'Accessories',
      ),
      ProductModel(
        id: '9',
        name: 'Designer Handbag',
        description: 'desc',
        imageUrl: 'https://via.placeholder.com/150',
        price: 180.00,
        rating: 4.7,
        category: 'Women',
      ),
      ProductModel(
        id: '10',
        name: 'Gaming Headset',
        description: 'desc',
        imageUrl: 'https://via.placeholder.com/150',
        price: 75.00,
        rating: 4.5,
        category: 'Electronics',
      ),
      ProductModel(
        id: '11',
        name: 'Smart Fitness Tracker',
        description: 'desc',
        imageUrl: 'https://via.placeholder.com/150',
        price: 50.00,
        rating: 4.4,
        category: 'Electronics',
      ),
    ];
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Mens'),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.surface2.withAlpha(200),
                        foregroundColor: AppColors.foreground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        textStyle: theme.textTheme.labelLarge,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingXXL,
                          vertical: AppConstants.paddingL,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text('Womens'),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.surface2.withAlpha(200),
                        foregroundColor: AppColors.foreground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        textStyle: theme.textTheme.labelLarge,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingXXL,
                          vertical: AppConstants.paddingL,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text('Kids'),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.surface2.withAlpha(200),
                        foregroundColor: AppColors.foreground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        textStyle: theme.textTheme.labelLarge,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingXXL,
                          vertical: AppConstants.paddingL,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text('News'),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.surface2.withAlpha(200),
                        foregroundColor: AppColors.foreground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        textStyle: theme.textTheme.labelLarge,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingXXL,
                          vertical: AppConstants.paddingL,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text('Sports'),
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.surface2.withAlpha(200),
                        foregroundColor: AppColors.foreground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        textStyle: theme.textTheme.labelLarge,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingXXL,
                          vertical: AppConstants.paddingL,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ProductSection(
                title: 'Recommended for you',
                products: recommendedProducts,
                onSeeAll: () {},
              ),
              const SizedBox(height: 24),
              ProductSection(
                title: 'On Sale',
                products: onSaleProducts,
                onSeeAll: () {},
              ),

              const SizedBox(height: 24),

              FeaturedProductsSection(
                title: 'Featured Products',
                products: featuredProducts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
