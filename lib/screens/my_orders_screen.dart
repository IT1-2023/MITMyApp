import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../services/order_service.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  Color _statusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Approved":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔴 MOCK – kasnije će biti po userId
    final List<Order> myOrders =
        OrderService.getOrders().where((o) => o.customerName == "John Doe").toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.orange,
      ),
      body: myOrders.isEmpty
          ? const Center(
              child: Text(
                "You have no orders yet",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myOrders.length,
              itemBuilder: (context, index) {
                final order = myOrders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order #${order.id}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Chip(
                            label: Text(order.status),
                            backgroundColor:
                                _statusColor(order.status).withOpacity(0.15),
                            labelStyle: TextStyle(
                              color: _statusColor(order.status),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text("Items: ${order.products.length}"),
                      Text(
                        "Total: \$${order.totalPrice}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Date: ${order.date.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
