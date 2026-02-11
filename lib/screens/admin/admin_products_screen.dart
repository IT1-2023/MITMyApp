import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/screens/admin/admin_add_product_screen.dart';
import 'package:restaurant_app/screens/admin/edit_product_screen.dart';
import 'package:restaurant_app/services/api_service.dart'; 

class AdminProductsScreen extends StatefulWidget {
  const AdminProductsScreen({super.key});

  @override
  State<AdminProductsScreen> createState() => _AdminProductsScreenState();
}

class _AdminProductsScreenState extends State<AdminProductsScreen> {

  
  List<Product> products = [];

  
  bool isLoading = true;

  String? error;

  @override
  void initState() {
    super.initState();
    loadProducts(); 
  }

  
  Future<void> loadProducts() async {
    try {

      final data = await ApiService.getProducts();

      if (!mounted) return;

      setState(() {
        products = data;
        isLoading = false;
      });

    } catch (e) {

      if (!mounted) return;

      setState(() {
        error = "Failed to load products";
        isLoading = false;
      });
    }
  }

  //  DELETE preko API
  Future<void> _deleteProduct(Product product) async {

    try {

      const token = "ADMIN_TOKEN"; // kasnije ide iz AuthService

      await ApiService.deleteProduct(product.id!);

      await loadProducts(); //  reload liste

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${product.name} deleted")),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Delete failed")),
      );
    }
  }

  // refresh posle edit
  Future<void> _editProduct(Product product) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProductScreen(product: product),
      ),
    );

    if (result == true) {
      loadProducts(); 
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
      loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {

    //LOADING
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ERROR
    if (error != null) {
      return Scaffold(
        body: Center(child: Text(error!)),
      );
    }

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

                // ako backend vraca URL slike koristimo NetworkImage
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _productImage(product.imageUrl),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(product.category,
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text("\$${product.price}",
                          style: const TextStyle(color: Colors.orange)),
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

  Widget _productImage(String imageUrl) {
    final resolved = ApiService.resolveImagePath(imageUrl);
    if (resolved.isEmpty) {
      return _imagePlaceholder();
    }

    final uri = Uri.tryParse(resolved);
    final isNetwork = uri != null &&
        (uri.scheme.toLowerCase() == "http" ||
            uri.scheme.toLowerCase() == "https");

    if (isNetwork) {
      return Image.network(
        resolved,
        width: 70,
        height: 70,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imagePlaceholder(),
      );
    }

    return Image.asset(
      resolved,
      width: 70,
      height: 70,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _imagePlaceholder(),
    );
  }

  Widget _imagePlaceholder() {
    return const Icon(Icons.image, size: 70);
  }
}

