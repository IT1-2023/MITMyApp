import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/wishlist_model.dart';
import 'package:restaurant_app/widgets/product_card.dart';

class MyWishlistScreen extends StatefulWidget {
  const MyWishlistScreen({super.key});

  @override
  State<MyWishlistScreen> createState() => _MyWishlistScreenState();
}

class _MyWishlistScreenState extends State<MyWishlistScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WishlistModel>().load());
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistModel>();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Wishlist"),
        backgroundColor: Colors.orange,
      ),
      body: wishlist.items.isEmpty
          ? const Center(
              child: Text(
                "Your wishlist is empty",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: wishlist.items.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: wishlist.items[index],
                );
              },
            ),
    );
  }
}
