import 'package:flutter/material.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/product.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  double _discountPercent = 0; // 0, 0.10, 0.20

  List<CartItem> get items => _items;

  // SUBTOTAL (bez popusta)
  double get subtotal =>
      _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  // DISCOUNT VALUE
  double get discountAmount => subtotal * _discountPercent;

  // TOTAL (sa popustom)
  double get totalPrice => subtotal - discountAmount;

  double get discountPercent => _discountPercent;

  // ADD or INCREASE
  void add(Product product) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  // DECREASE or REMOVE
  void decreaseQuantity(Product product) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  
  int quantity(Product product) {
    final index =
        _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      return _items[index].quantity;
    }
    return 0;
  }

  // PROMO CODE
bool applyPromoCode(String code) {
  if (code == "SAVE10") {
    _discountPercent = 0.10;
  } else if (code == "SAVE20") {
    _discountPercent = 0.20;
  } else {
    _discountPercent = 0.0; // reset
    notifyListeners();
    return false;
  }

  notifyListeners();
  return true;
}


  void clear() {
    _items.clear();
    _discountPercent = 0;
    notifyListeners();
  }
}
