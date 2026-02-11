import 'package:restaurant_app/models/product.dart';

class CartItem{
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity=1,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson({
        "_id": json["productId"],
        "name": json["name"],
        "description": json["description"],
        "price": json["price"],
        "imageUrl": json["imageUrl"],
        "rating": json["rating"] ?? 0,
        "category": json["category"],
      }),
      quantity: json["quantity"] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": product.id,
      "name": product.name,
      "description": product.description,
      "price": product.price,
      "imageUrl": product.imageUrl,
      "rating": product.rating,
      "category": product.category,
      "quantity": quantity,
    };
  }



}