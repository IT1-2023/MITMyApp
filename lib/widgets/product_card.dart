import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/cart_model.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/models/wishlist_model.dart';
import 'package:restaurant_app/screens/product_details_screen.dart';
import 'package:restaurant_app/services/auth_service.dart';
import 'package:restaurant_app/widgets/rating_stars.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  void _requireCustomer(BuildContext context, VoidCallback onSuccess) {
    if (!AuthService.isLoggedIn()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please login to continue")));
      Navigator.pushNamed(context, "/login");
      return;
    }

    if (AuthService.isAdmin()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Admins cannot add to cart or wishlist"),
        ),
      );
      return;
    }

    onSuccess();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final wishlist = context.watch<WishlistModel>();
    final isAdmin = AuthService.isAdmin();

    final isFav = wishlist.isInWishlist(product);

    final index = cart.items.indexWhere(
      (item) => item.product.id == product.id,
    );
    final qty = index >= 0 ? cart.items[index].quantity : 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  product.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                if (!isAdmin)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.white,
                      ),
                      onPressed: () async {
                        _requireCustomer(context, () async {
                          await wishlist.toggle(product);
                        });
                      },
                    ),
                  ),

                if (!isAdmin)
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: qty == 0
                        ? _circleBtn(Icons.add, Colors.orange, () {
                            _requireCustomer(context, () {
                              cart.add(product);
                            });
                          })
                        : Row(
                            children: [
                              _circleBtn(Icons.remove, Colors.red, () {
                                _requireCustomer(context, () {
                                  cart.decreaseQuantity(product);
                                });
                              }),
                              const SizedBox(width: 6),
                              Text(
                                qty.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 6),
                              _circleBtn(Icons.add, Colors.orange, () {
                                _requireCustomer(context, () {
                                  cart.add(product);
                                });
                              }),
                            ],
                          ),
                  ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(color: Colors.red),
                  ),
                  RatingStars(rating: product.rating),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: color,
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}
