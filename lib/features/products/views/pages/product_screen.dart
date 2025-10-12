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
        imageUrl:
            'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=387',
        price: 29.99,
        rating: 4.8,
        description: 'High-quality black t-shirt made from premium cotton.',
        category: 'Men',
      ),
      ProductModel(
        id: '2',
        name: 'Classic Sneaker',
        imageUrl:
            'https://images.unsplash.com/photo-1739444929249-5af4d61276a9?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=871',
        price: 89.99,
        rating: 4.6,
        description: 'Timeless white sneakers for everyday comfort.',
        category: 'Footwear',
      ),
      ProductModel(
        id: '5',
        name: 'Leather Boots',
        imageUrl:
            'https://images.unsplash.com/photo-1599012307605-23a0ebe4d321?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=387',
        price: 120.00,
        rating: 4.9,
        description: 'Durable and stylish leather boots for all seasons.',
        category: 'Footwear',
      ),
      ProductModel(
        id: '6',
        name: 'Casual Hat',
        imageUrl:
            'https://images.unsplash.com/photo-1720303671404-dd4b5b71cd91?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=387',
        price: 25.50,
        rating: 4.3,
        description: 'Comfortable and trendy casual hat.',
        category: 'Accessories',
      ),
    ];

    final List<ProductModel> onSaleProducts = [
      ProductModel(
        id: '3',
        name: 'Summer Dress',
        imageUrl:
            'https://images.unsplash.com/photo-1568381478053-82d1ba959b6c?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=387',
        price: 49.99,
        oldPrice: 69.99,
        rating: 4.5,
        description: 'Light and airy summer dress perfect for sunny days.',
        category: 'Women',
      ),
      ProductModel(
        id: '4',
        name: 'Men\'s Jacket',
        imageUrl:
            'https://images.unsplash.com/photo-1715608720717-ac3d1b638e44?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=385',
        price: 115.20,
        oldPrice: 150.00,
        rating: 4.7,
        description: 'Stylish and warm jacket for men.',
        category: 'Men',
      ),
      ProductModel(
        id: '7',
        name: 'Sports Watch',
        imageUrl:
            'https://images.unsplash.com/photo-1669480380743-f76990b9bc44?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=774',
        price: 199.99,
        oldPrice: 249.99,
        rating: 4.4,
        description: 'Advanced sports watch with fitness tracking features.',
        category: 'Electronics',
      ),
      ProductModel(
        id: '8',
        name: 'Running Shoes',
        imageUrl:
            'https://images.unsplash.com/photo-1597892657493-6847b9640bac?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=387', // Running Shoes
        price: 75.00,
        oldPrice: 95.00,
        rating: 4.6,
        description: 'Lightweight and comfortable running shoes.',
        category: 'Footwear',
      ),
    ];

    final List<ProductModel> featuredProducts = [
      ProductModel(
        id: '9',
        name: 'Luxury Watch',
        description: 'Elegant timepiece for a sophisticated look.',
        imageUrl:
            'https://images.unsplash.com/photo-1634140704051-58a787556cd1?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=774', // Luxury Watch
        price: 250.00,
        rating: 4.9,
        category: 'Accessories',
      ),
      ProductModel(
        id: '10',
        name: 'Designer Handbag',
        description: 'Stylish handbag for women, perfect for any occasion.',
        imageUrl:
            'https://images.unsplash.com/photo-1601924921557-45e6dea0a157?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=870', // Designer Handbag
        price: 180.00,
        rating: 4.7,
        category: 'Women',
      ),
      ProductModel(
        id: '11',
        name: 'Gaming Headset',
        description: 'Immersive gaming experience with superior sound quality.',
        imageUrl:
            'https://images.unsplash.com/photo-1660391532247-4a8ad1060817?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=581',
        price: 75.00,
        rating: 4.5,
        category: 'Electronics',
      ),
      ProductModel(
        id: '12',
        name: 'Smart Fitness Tracker',
        description: 'Track your health and fitness goals with ease.',
        imageUrl:
            'https://plus.unsplash.com/premium_photo-1712761997182-45455a50d8c4?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=870', // Smart Fitness Tracker
        price: 50.00,
        rating: 4.4,
        category: 'Electronics',
      ),
    ];
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingL,
        ),
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
                      horizontal: AppConstants.paddingL,
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
