import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/services/wishlist_service.dart';

class WishlistModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  bool isInWishlist(Product product) {
    return _items.any((p) => p.id == product.id);
  }

  Future<void> load() async {
    _items
      ..clear()
      ..addAll(await WishlistService.getWishlist());
    notifyListeners();
  }

  Future<void> toggle(Product product) async {
    if (product.id == null) return;
    _items
      ..clear()
      ..addAll(await WishlistService.toggleWishlist(product.id!));
    notifyListeners();
  }

  Future<void> remove(Product product) async {
    if (product.id == null) return;
    _items
      ..clear()
      ..addAll(await WishlistService.removeFromWishlist(product.id!));
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

}
