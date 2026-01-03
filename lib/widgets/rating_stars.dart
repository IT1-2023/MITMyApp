import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget{
  final double rating;

  const RatingStars({required this.rating});

  Widget build(BuildContext context){
    return Row(
      children: List.generate(5, (index){
        return Icon(
          Icons.star_border,
          size: 18,
          color: Colors.orange,
        );
      }
    ),
    );
    
  }
}