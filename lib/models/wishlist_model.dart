import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';

class WishlistModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  bool isInWishlist(Product product) {
    return _items.any((p) => p.id == product.id);
  }

  void toggle(Product product) {
    final index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeAt(index);
    } else {
      _items.add(product);
    }

    notifyListeners();
  }

  void remove(Product product) {
    _items.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
