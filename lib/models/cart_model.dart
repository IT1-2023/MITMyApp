import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _items=[];

  List<Product> get items=> _items;

  double get totalPrice => 
  _items.fold(0,(sum,item) => sum + item.price);

  void add(Product product)
  {
    _items.add(product);
    notifyListeners();
  }
  void remove(Product product)
  {
    _items.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }
  void clear()
  {
    _items.clear();
    notifyListeners();
  }
}