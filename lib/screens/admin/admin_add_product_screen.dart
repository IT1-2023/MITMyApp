import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/services/product_service.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({super.key});

  @override
  State<AdminAddProductScreen> createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  String selectedCategory = "Salad";

  final categories = [
    "Salad",
    "Rolls",
    "Desserts",
    "Sandwich",
    "Cake",
    "Pure Veg",
    "Pasta",
    "Noodles",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Add Product"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE UPLOAD (placeholder)
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Upload Image", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// PRODUCT NAME
            _label("Product Name"),
            _inputField(nameCtrl, "Type here"),

            const SizedBox(height: 16),

            /// DESCRIPTION
            _label("Product Description"),
            TextField(
              controller: descCtrl,
              maxLines: 4,
              decoration: _inputDecoration("Write content here"),
            ),

            const SizedBox(height: 16),

            /// CATEGORY + PRICE
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Product Category"),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCategory,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: categories
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label("Product Price"),
                      _inputField(
                        priceCtrl,
                        "\$20",
                        keyboard: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// ADD BUTTON
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (nameCtrl.text.trim().isEmpty ||
                      priceCtrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Name and price are required"),
                      ),
                    );
                    return;
                  }

                  final newProduct = Product(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: nameCtrl.text,
                    description: descCtrl.text,
                    price: double.tryParse(priceCtrl.text) ?? 0,
                    imageUrl: "assets/images/food_1.png", // placeholder
                    rating: 0,
                    category: selectedCategory,
                  );

                  ProductService.addProduct(newProduct);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product added")),
                  );

                  Navigator.pop(context, true);
                },
                child: const Text("ADD", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// helpers
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _inputField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: _inputDecoration(hint),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
