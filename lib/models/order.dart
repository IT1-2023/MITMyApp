import 'product.dart';

class Order {
  final int id;
  final String customerName;
  final List<Product> products;
  final double totalPrice;
  String status; // Pending, Approved, Delivered, Cancelled
  final DateTime date;

  Order({
    required this.id,
    required this.customerName,
    required this.products,
    required this.totalPrice,
    required this.status,
    required this.date,
  });
}
