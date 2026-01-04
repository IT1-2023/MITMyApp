import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/services/product_service.dart';
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
  String? selectedCategory;
  late List<Product> allProducts;
  late List<Product> filteredProducts;

  @override
  void initState() {
    super.initState();
    allProducts = ProductService.getProducts();
    filteredProducts = allProducts;
  }

  void filterByCategory(String category) {
    setState(() {
      if (selectedCategory == category) {
        // kliknuta ista kategorija → ukloni filter
        selectedCategory = null;
        filteredProducts = allProducts;
      } else {
        // nova kategorija → filtriraj
        selectedCategory = category;
        filteredProducts = allProducts
            .where((p) => p.category == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //banner
            
               Stack(
                
                children: [
                  Image.asset(
                    "assets/images/header_img.png",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // tamni overlay
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.4),
                  ),

                  // tekst preko banera
                  Positioned(
                    left: 16,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            

            const SizedBox(height: 16),

            //HORIZONTALNI MENI
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category["name"] == selectedCategory;

                  return GestureDetector(
                    onTap: () => filterByCategory(category["name"]!),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                              radius: 32,
                              backgroundImage: AssetImage(category["image"]!),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            category["name"]!,
                            style: TextStyle(
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
            if (selectedCategory != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "Filtered by: $selectedCategory",
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
