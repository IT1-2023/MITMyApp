import 'package:flutter/material.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/product.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items=[];

  List<CartItem> get items=> _items;

  double get totalPrice => 
  _items.fold(0,(sum,item) => sum + item.product.price*item.quantity);

  void add(Product product)
  {
    final index = 
    _items.indexWhere((item) => item.product.id == product.id);

    if(index>=0){
      _items[index].quantity++;
    } else{
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }
  void remove(Product product)
  {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }
  void increaseQuantity(Product product) {
    final item =
        _items.firstWhere((item) => item.product.id == product.id);
    item.quantity++;
    notifyListeners();
  }

   void decreaseQuantity(Product product) {
    final item =
        _items.firstWhere((item) => item.product.id == product.id);

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void clear()
  {
    _items.clear();
    notifyListeners();
  }
}