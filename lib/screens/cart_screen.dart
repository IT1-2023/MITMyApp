import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/cart_model.dart';

class CartScreen extends StatelessWidget{
    const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final cart = context.watch<CartModel>();

    return  Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
         padding: const EdgeInsets.all(16),
         child: cart.items.isEmpty ? const Center(child: Text("Your cart is empty.", style: TextStyle(fontSize: 16),
         ),
        )
        : Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //HEADER
            const Text("Items", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
// CART ITEMS
Expanded(
  child: ListView.separated(
    itemCount: cart.items.length,
    separatorBuilder: (_, __) => const Divider(height: 1),
    itemBuilder: (context, index) {
      final product = cart.items[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(product.name),
            ),
            Expanded(
              child: Text("\$${product.price}"),
            ),
            const Expanded(
              child: Text("1"), // quantity (za sada 1)
            ),
            Expanded(
              child: Text("\$${product.price}"),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => cart.remove(product),
            ),
          ],
        ),
      );
    },
  ),
),

const SizedBox(height: 24),


         // CART TOTALS
                    const Text(
                      "Cart Totals",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    _priceRow("Subtotal", cart.totalPrice),
                    _priceRow("Delivery Fee", 0),
                    const Divider(),
                    _priceRow(
                      "Total",
                      cart.totalPrice,
                      isBold: true,
                    ),

                    const SizedBox(height: 16),

                    //PROMO CODE 
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Promo code",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: const Text("Apply"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    //CHECKOUT BUUTON

                 SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "PROCEED TO CHECKOUT",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
    ),
    ),

    );
  }

  Widget _priceRow(String label, double value,{bool isBold = false} ){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style:TextStyle(fontWeight: isBold? FontWeight.bold : null),
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : null),

        ),
      ],
    ),);
  }
}