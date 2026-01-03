import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/screens/product_details_screen.dart';
import 'package:restaurant_app/widgets/rating_stars.dart';

class ProductCard extends StatelessWidget{
  final Product product;
  const ProductCard({required this.product});

  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product:product),
        ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl,height: 120,fit: BoxFit.cover),
            Padding(padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name,style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(product.description, maxLines: 2),
              Text("\$${product.price}", style: const TextStyle(color: Colors.red)),
              RatingStars(rating: product.rating),
            ],),)
          ],
        ),
      ),
    );
  }

}