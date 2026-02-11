import 'package:restaurant_app/models/cart_item.dart';



class Order {
  final String id;
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
    factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["_id"] ?? "",
      userId: json["userId"] ?? "",
      customerName: json["customerName"] ?? "",
      items: (json["items"] as List? ?? [])
          .map((i) => CartItem.fromJson(i))
          .toList(),
      totalPrice: (json["totalPrice"] ?? 0).toDouble(),
      status: json["status"] ?? "Pending",
      date: DateTime.tryParse(json["date"] ?? "") ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "customerName": customerName,
      "items": items.map((i) => i.toJson()).toList(),
      "totalPrice": totalPrice,
      "status": status,
      "date": date.toIso8601String(),
    };
  }

}
