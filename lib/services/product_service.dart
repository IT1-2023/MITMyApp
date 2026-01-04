import 'package:restaurant_app/models/product.dart';

class ProductService {
  static List <Product> getProducts(){
    return[
      Product(
        id:1,
        name:"Butter Noodles",
        description:"Tasty noodles with butter",
        price:14.0,
        imageUrl: "https://images.unsplash.com/photo-1603133872878-684f9f7e4f1d",
        rating: 0,
        category: "Noodles"
      ),
      Product(
        id:2,
        name:"Veg Noodles",
        description:"Healthy vegetable noodles",
        price:12.0,
        imageUrl:"http://images.unsplash.com/photo-1603133872878-684f9f7e4f1d",
        rating: 0,
        category: "Noodles"
      ),
    ];
  }
}