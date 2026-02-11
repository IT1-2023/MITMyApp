import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/cart_model.dart';
import 'package:restaurant_app/models/wishlist_model.dart';
import 'package:restaurant_app/screens/cart_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/profile_wrapper.dart';
import 'package:restaurant_app/screens/search_screen.dart';
import 'package:restaurant_app/services/auth_service.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final wishlist = context.read<WishlistModel>();
      if (AuthService.isLoggedIn()) {
        wishlist.load();
      } else {
        wishlist.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = AuthService.isAdmin();

    final screens = [
      HomeScreen(),
      SearchScreen(),
      if (!isAdmin) CartScreen(),
      const ProfileWrapper(),
    ];

    final items = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: "Search",
      ),
      if (!isAdmin)
        BottomNavigationBarItem(
          label: "Cart",
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart),
              Positioned(
                right: -6,
                top: -6,
                child: Consumer<CartModel>(
                  builder: (context, cart, child) {
                    if (cart.items.isEmpty) {
                      return const SizedBox();
                    }
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        cart.items.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "Profile",
      ),
    ];

    if (_currentIndex >= screens.length) {
      _currentIndex = screens.length - 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("RESTAURANT APP"),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: items,
      ),
    );
  }
}
