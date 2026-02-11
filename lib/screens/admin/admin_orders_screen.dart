import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../services/order_service.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  
  String selectedStatus = "All";

  Future<List<Order>> _loadOrders() {
    return OrderService.getAllOrders();
  }

  Future<void> _changeStatus(Order order, String status) async {
    try {
      await OrderService.updateStatus(order.id, status);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order #${order.id} -> $status")),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update status")),
      );
    }
  }

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

  List<Order> _filterOrders(List<Order> orders) {
    if (selectedStatus == "All") return orders;
    return orders.where((o) => o.status == selectedStatus).toList();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Manage Orders"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // FILTER
          Padding(
            padding: const EdgeInsets.all(12),
            child: DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(value: "All", child: Text("All orders")),
                DropdownMenuItem(value: "Pending", child: Text("Pending")),
                DropdownMenuItem(value: "Approved", child: Text("Approved")),
                DropdownMenuItem(value: "Delivered", child: Text("Delivered")),
                DropdownMenuItem(value: "Cancelled", child: Text("Cancelled")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
            ),
          ),

          // LISTA
 Expanded(
            child: FutureBuilder<List<Order>>(
              future: _loadOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Failed to load orders",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                final orders = _filterOrders(snapshot.data ?? []);

                if (orders.isEmpty) {
                  return const Center(
                    child: Text(
                      "No orders",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];

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
                            children: [
                              Expanded(
                                child: Text(
                                  "Order #${order.id}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Chip(
                                label: Text(order.status),
                                backgroundColor: _statusColor(
                                  order.status,
                                ).withOpacity(0.15),
                                labelStyle: TextStyle(
                                  color: _statusColor(order.status),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text("Customer: ${order.customerName}"),
                          Text("Items: ${order.items.length}"),
                          const SizedBox(height: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: order.items.map((item) {
                              return Text(
                                "- ${item.product.name} x ${item.quantity}",
                                style: const TextStyle(fontSize: 13),
                              );
                            }).toList(),
                          ),
                          Text(
                            "Total: \$${order.totalPrice}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 12),

                          if (order.status == "Pending")
                            Row(
                              children: [
                                Expanded(
                                  child: _actionBtn(
                                    "Approve",
                                    Colors.green,
                                    () => _changeStatus(order, "Approved"),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _actionBtn(
                                    "Cancel",
                                    Colors.red,
                                    () => _changeStatus(order, "Cancelled"),
                                  ),
                                ),
                              ],
                            ),

                          if (order.status == "Approved")
                            _actionBtn(
                              "Mark as Delivered",
                              Colors.blue,
                              () => _changeStatus(order, "Delivered"),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionBtn(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}


