import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/services/api_service.dart';

import 'package:restaurant_app/widgets/search_product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> allProducts=[];
  List<Product> filteredProducts = [];
    bool isLoading = true;
    String? error;
    


  @override
  void initState() {
    super.initState();
  _loadProducts();
  }
   Future<void> _loadProducts() async {
    try {
      final products = await ApiService.getProducts();
    if (!mounted) return;

      setState(() {
        allProducts = products;
        filteredProducts = products;
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
 void _filterProducts(String query) {

    final results = allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
     if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
        if (error != null) {
      return Scaffold(
        body: Center(child: Text(error!)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search food",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // SEARCH BAR
              TextField(
                onChanged: _filterProducts,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search for dishes...",
                  filled: true,
                  fillColor: Colors.white,
                   contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // RESULTS
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SearchProductCard(
                              product: filteredProducts[index],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
