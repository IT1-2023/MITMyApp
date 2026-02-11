import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/cart_model.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/services/auth_service.dart';
import 'package:restaurant_app/widgets/rating_stars.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late double _currentRating;
  bool _ratingLoading = false;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.product.rating;
  }

  void _requireCustomer(BuildContext context, VoidCallback onSuccess) {
    if (!AuthService.isLoggedIn()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please login to continue")),
      );
      Navigator.pushNamed(context, "/login");
      return;
    }

    if (AuthService.isAdmin()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Admins cannot rate products or place orders"),
        ),
      );
      return;
    }

    onSuccess();
  }

  Future<void> _rate(int value) async {
    if (widget.product.id == null) return;

    setState(() => _ratingLoading = true);
    try {
      final updated = await ApiService.rateProduct(widget.product.id!, value);
      setState(() {
        _currentRating = updated.rating;
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit rating")),
      );
    } finally {
      if (mounted) setState(() => _ratingLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final isAdmin = AuthService.isAdmin();

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                product.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(product.description),
              const SizedBox(height: 8),
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              RatingStars(rating: _currentRating),
              const SizedBox(height: 12),
              if (_ratingLoading)
                const Center(child: CircularProgressIndicator())
              else if (isAdmin)
                const Text(
                  "Admin accounts cannot rate products.",
                  style: TextStyle(color: Colors.grey),
                )
              else
                Row(
                  children: List.generate(5, (i) {
                    final value = i + 1;
                    return IconButton(
                      icon: const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        _requireCustomer(context, () => _rate(value));
                      },
                    );
                  }),
                ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isAdmin
                ? null
                : () {
                    _requireCustomer(context, () {
                      context.read<CartModel>().add(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to cart")),
                      );
                    });
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              isAdmin ? "ADMIN CANNOT ORDER" : "Add to cart",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
