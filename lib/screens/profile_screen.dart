import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/cart_model.dart';
import 'package:restaurant_app/models/wishlist_model.dart';
import 'package:restaurant_app/screens/admin/admin_add_product_screen.dart';
import 'package:restaurant_app/screens/admin/admin_orders_screen.dart';
import 'package:restaurant_app/screens/admin/admin_products_screen.dart';
import 'package:restaurant_app/screens/my_address_screen.dart';
import 'package:restaurant_app/screens/my_orders_screen.dart';
import 'package:restaurant_app/screens/my_wishlist_screen.dart';
import 'package:restaurant_app/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser!;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.isAdmin ? "Role: Admin" : "Role: User",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    if (!user.isAdmin) ...[
                      _tile(Icons.receipt_long, "My Orders", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyOrdersScreen(),
                          ),
                        );
                      }),
                      _tile(Icons.location_on, "My Address", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyAddressScreen(),
                          ),
                        );
                      }),
                      _tile(Icons.favorite, "My Wishlist", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyWishlistScreen(),
                          ),
                        );
                      }),
                    ],
                    if (user.isAdmin) ...[
                      _tile(Icons.add_box, "Add Product", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminAddProductScreen(),
                          ),
                        );
                      }),
                      _tile(Icons.edit, "Edit / Delete Products", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminProductsScreen(),
                          ),
                        );
                      }),
                      _tile(Icons.local_shipping, "Manage Orders", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminOrdersScreen(),
                          ),
                        );
                      }),
                    ],
                    const SizedBox(height: 8),
                    _tile(Icons.logout, "Logout", () async {
                      await AuthService.logout();
                      if (!context.mounted) return;
                      context.read<WishlistModel>().clear();
                      context.read<CartModel>().clear();
                      onLogout();
                    }, isRed: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isRed = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: isRed ? Colors.red : Colors.black87),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isRed ? Colors.red : Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
