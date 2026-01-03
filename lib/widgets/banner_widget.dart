import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://images.unsplash.com/food"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        "RestaurantApp",
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
