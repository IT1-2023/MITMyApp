import 'package:restaurant_app/models/cart_item.dart';



class Order {
  final int id;
  final String userId;
  final String customerName;
  final List<CartItem> items;
  final double totalPrice;
  String status; // Pending, Approved, Delivered, Cancelled
  final DateTime date;

  Order({
    required this.id,
     required this.userId,
    required this.customerName,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.date,
  });
}
