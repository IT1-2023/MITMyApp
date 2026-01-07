import 'package:flutter/material.dart';
import 'package:restaurant_app/models/product.dart';
import 'package:restaurant_app/services/product_service.dart';


class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController descCtrl;
  late TextEditingController priceCtrl;
  late String selectedCategory;

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
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.product.name);
    descCtrl = TextEditingController(text: widget.product.description);
    priceCtrl =
        TextEditingController(text: widget.product.price.toString());
    selectedCategory = widget.product.category;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (nameCtrl.text.trim().isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Product name is required")),
  );
  return;
}
  final updatedProduct = Product(
    id: widget.product.id,
    name: nameCtrl.text,
    description: descCtrl.text,
    price: double.tryParse(priceCtrl.text) ?? widget.product.price,
    imageUrl: widget.product.imageUrl,
    rating: widget.product.rating,
    category: selectedCategory,
  );

  ProductService.updateProduct(updatedProduct);
    ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text("Product updated")),
);

Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Edit Product"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("Product name"),
            _input(nameCtrl),

            const SizedBox(height: 16),

            _label("Description"),
            _input(descCtrl, maxLines: 4),

            const SizedBox(height: 16),

            _label("Category"),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedCategory = value!);
              },
              decoration: _decoration(),
            ),

            const SizedBox(height: 16),

            _label("Price"),
            _input(priceCtrl, keyboardType: TextInputType.number),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "SAVE CHANGES",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _input(
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: _decoration(),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
