import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_theme.dart';
import 'package:ecommerce_app/features/products/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = [
      CategoryModel(
        id: '0',
        name: 'Shirts & Tops',
        CategoryNumber: 234,
        imageUrl: 'https://picsum.photos/seed/picsum/100',
      ),
      CategoryModel(
        id: '1',
        name: 'Shoes & Sneakers',
        CategoryNumber: 156,
        imageUrl: 'https://picsum.photos/seed/picsum/100',
      ),
      CategoryModel(
        id: '2',
        name: 'Jeans & Denim',
        CategoryNumber: 89,
        imageUrl: 'https://picsum.photos/seed/picsum/100',
      ),
      CategoryModel(
        id: '3',
        name: 'Jacket & Coats',
        CategoryNumber: 92,
        imageUrl: 'https://picsum.photos/seed/picsum/100',
      ),
      CategoryModel(
        id: '4',
        name: 'Dresses',
        CategoryNumber: 178,
        imageUrl: 'https://picsum.photos/seed/picsum/100',
      ),
      CategoryModel(
        id: '5',
        name: 'Bags & Accessories',
        CategoryNumber: 134,
        imageUrl: 'https://picsum.photos/seed/picsum/100',
      ),
    ];
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Shop by Category',
              style: TextStyle(
                color: AppColors.foreground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover your style',
              style: TextStyle(color: AppColors.secondary, fontSize: 15),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.productsRoute,arguments: categories[index].name);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Image.network(
                            categories[index].imageUrl,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    categories[index].name,
                                    style: 
                                    TextStyle(
                                      color: AppColors.foreground,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${categories[index].CategoryNumber} items',
                                    style: TextStyle(
                                      color: AppColors.secondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
