import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/screens/admin/admin_add_product_screen.dart';
import 'package:restaurant_app/screens/admin/edit_product_screen.dart';
import 'package:restaurant_app/services/product_service.dart';

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = List.from(ProductService.getProducts());
  }

  void _deleteProduct(Product product) {
    setState(() {
      products.remove(product);
      ProductService.deleteProduct(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} deleted")),
    );
  }

  Future<void> _editProduct(Product product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProductScreen(product: product),
      ),
    );

    if (result == true) {
      setState(() {
        products = List.from(ProductService.getProducts());
      });
    }
  }

  Future<void> _addProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AdminAddProductScreen(),
      ),
    );

    if (result == true) {
      setState(() {
        products = List.from(ProductService.getProducts());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Edit / Delete Products"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addProduct,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    product.imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.category,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _editProduct(product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(product),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(Product product) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete product"),
        content: Text("Are you sure you want to delete ${product.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              _deleteProduct(product);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
