import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/widgets/footer_section.dart';
import 'package:restaurant_app/widgets/product_card.dart';

const List<Map<String, String>> categories = [
  {"name": "Salad", "image": "assets/images/menu_1.png"},
  {"name": "Rolls", "image": "assets/images/menu_2.png"},
  {"name": "Desserts", "image": "assets/images/menu_3.png"},
  {"name": "Sandwich", "image": "assets/images/menu_4.png"},
  {"name": "Cake", "image": "assets/images/menu_5.png"},
  {"name": "Pure Veg", "image": "assets/images/menu_6.png"},
  {"name": "Pasta", "image": "assets/images/menu_7.png"},
  {"name": "Noodles", "image": "assets/images/menu_8.png"},
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Product> allProducts = [];
  List<Product> filteredProducts = [];

  bool isLoading = true;
  String? error;

  String? selectedCategory;
  String? priceSort;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // LOAD PRODUCTS 
  Future<void> loadProducts() async {
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

  // FILTER
  void filterByCategory(String category) {
    setState(() {
      priceSort = null;

      if (selectedCategory == category) {
        selectedCategory = null;
        filteredProducts = List.from(allProducts);
      } else {
        selectedCategory = category;
        filteredProducts =
            allProducts.where((p) => p.category == category).toList();
      }
    });
  }

  //  SORT
  void sortByPrice(String? value) {
    setState(() {
      priceSort = value;

      if (value == "asc") {
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      } else if (value == "desc") {
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // LOADING
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    //  ERROR
    if (error != null) {
      return Scaffold(
        body: Center(child: Text(error!)),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // BANNER
            Stack(
              children: [
                Image.asset(
                  "assets/images/header_img.png",
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 180,
                  color: Colors.black.withOpacity(0.4),
                ),
                const Positioned(
                  left: 16,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delicious food",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Discover our menu",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            //  CATEGORY MENU
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                itemBuilder: (context, index) {

                  final category = categories[index];
                  final isSelected = category["name"] == selectedCategory;

                  return GestureDetector(
                    onTap: () => filterByCategory(category["name"]!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? Colors.orange
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  AssetImage(category["image"]!),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            category["name"]!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // SORT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  if (selectedCategory != null)
                    Text("Filtered by: $selectedCategory"),

                  DropdownButton<String>(
                    value: priceSort,
                    hint: const Text("Sort by price"),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(
                        value: "asc",
                        child: Text("Price: Low → High"),
                      ),
                      DropdownMenuItem(
                        value: "desc",
                        child: Text("Price: High → Low"),
                      ),
                    ],
                    onChanged: sortByPrice,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // PRODUCTS GRID
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: filteredProducts[index]);
              },
            ),

            const SizedBox(height: 30),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
