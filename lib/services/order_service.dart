import '../models/order.dart';
import '../models/cart_item.dart';
import '../services/auth_service.dart';

class OrderService {
  static final List<Order> _orders = [];

  static List<Order> getOrders() => _orders;

  static List<Order> getOrdersForUser(String userId) {
    return _orders.where((o) => o.userId == userId).toList();
  }

  static void createOrder({
    required List<CartItem> items,
    required double totalPrice,
  }) {
    final user = AuthService.currentUser;
    if (user == null) return;

    _orders.add(
      Order(
        id: _orders.length + 1,
        userId: user.id,
        customerName: user.name,
        items: List.from(items), 
        totalPrice: totalPrice,
        status: "Pending",
        date: DateTime.now(),
      ),
    );
  }

  static void updateStatus(int orderId, String status) {
    final order = _orders.firstWhere((o) => o.id == orderId);
    order.status = status;
  }
}
