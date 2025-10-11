import 'package:flutter/material.dart';
import 'package:ecommerce_app/core/theme/app_theme.dart';
import '../../../../core/widgets/product_card.dart';
import '../../models/product_model.dart';

class FeaturedProductsSection extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const FeaturedProductsSection({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title, style: textTheme.displaySmall)],
        ),
        const SizedBox(height: AppConstants.paddingL),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppConstants.paddingM,
            mainAxisSpacing: AppConstants.paddingM,
            childAspectRatio: 0.65,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        ),
      ],
    );
  }
}
