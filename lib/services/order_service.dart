import '../models/order.dart';
import '../models/product.dart';

class OrderService {
  static final List<Order> _orders = [
    Order(
      id: 1,
      customerName: "John Doe",
      products: [
        Product(
          id: 1,
          name: "Greek Salad",
          description: "",
          price: 12,
          imageUrl: "",
          rating: 4.5,
          category: "Salad",
        ),
      ],
      totalPrice: 12,
      status: "Pending",
      date: DateTime.now(),
    ),

    Order(
      id: 2,
      customerName: "Anna Smith",
      products: [
        Product(
          id: 2,
          name: "Veg Rolls",
          description: "",
          price: 15,
          imageUrl: "",
          rating: 4.2,
          category: "Rolls",
        ),
        Product(
          id: 3,
          name: "Ice Cream",
          description: "",
          price: 10,
          imageUrl: "",
          rating: 4.8,
          category: "Desserts",
        ),
      ],
      totalPrice: 25,
      status: "Approved",
      date: DateTime.now(),
    ),
  ];

  static List<Order> getOrders() {
    return _orders;
  }

  static void updateStatus(int id, String newStatus) {
    final index = _orders.indexWhere((o) => o.id == id);
    if (index != -1) {
      _orders[index].status = newStatus;
    }
  }
}
