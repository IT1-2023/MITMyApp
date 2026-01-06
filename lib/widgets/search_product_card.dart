import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/screens/product_details_screen.dart';
import 'package:restaurant_app/widgets/rating_stars.dart';

class SearchProductCard extends StatelessWidget {
  final Product product;

  const SearchProductCard({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child:  Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            //IMAGE
             ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
              child: Image.asset(
                product.imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),

            //CONTENT
            Expanded(child: Padding(padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name
                  ,
                  style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                ),
                const SizedBox(height: 4),

                Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text("\$${product.price}",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RatingStars(rating: product.rating)
              ],
            ),))
          ],
        ),
    )
    );
  }

}