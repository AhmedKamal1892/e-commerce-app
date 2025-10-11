import 'package:flutter/material.dart';
import '../../../../core/widgets/product_card.dart';
import '../../models/product_model.dart';
import 'package:ecommerce_app/core/theme/app_theme.dart';

class ProductSection extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final VoidCallback onSeeAll;

  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.displaySmall),
            InkWell(
              onTap: onSeeAll,
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 12.0,
                    color: AppColors.mutedForeground,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 280.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ProductCard(product: products[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
