import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/widgets/rating_stars.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 8),
            Text(
              "\$${product.price}",
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
            const SizedBox(height: 8),
            RatingStars(rating: product.rating),
          ],
        ),
      ),
    );
  }
}
