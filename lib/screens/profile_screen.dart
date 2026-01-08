import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/admin/admin_orders_screen.dart';
import 'package:restaurant_app/services/auth_service.dart';
import 'package:restaurant_app/screens/admin/admin_add_product_screen.dart';
import 'package:restaurant_app/screens/admin/admin_products_screen.dart';

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

              //user card
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
              // OPTIONS
              Expanded(
                child: ListView(
                  children: [
                    if (!user.isAdmin) ...[
                      _tile(Icons.receipt_long, "My Orders", () {}),
                      _tile(Icons.location_on, "My Address", () {}),
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

                    _tile(Icons.logout, "Logout", () {
                      AuthService.logout();
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
