import 'package:restaurant_app/models/product.dart';

class ProductService {
  static final List <Product> _products=
    [
      Product(
        id:1,
        name:"Greek Salad",
        description:"Food provides essential nutrients for overall health and well-being",
        price:12,
        imageUrl: "assets/images/food_1.png",
        rating: 0,
        category: "Salad"
      ),
Product(
        id: 2,
        name: "Veg Salad",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 18,
        imageUrl: "assets/images/food_2.png",
        rating: 4.3,
        category: "Salad",
      ),
            Product(
        id: 3,
        name: "Clover Salad",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 16,
        imageUrl: "assets/images/food_3.png",
        rating: 4.4,
        category: "Salad",
      ),
            Product(
        id: 4,
        name: "Chicken Salad",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 24,
        imageUrl: "assets/images/food_4.png",
        rating: 4.8,
        category: "Salad",
      ),
      //rolls
       Product(
        id: 5,
        name: "Lasagna Rolls",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 14,
        imageUrl: "assets/images/food_5.png",
        rating: 4.2,
        category: "Rolls",
      ),
        Product(
        id: 6,
        name: "Peri Peri Rolls",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 12,
        imageUrl: "assets/images/food_6.png",
        rating: 4.0,
        category: "Rolls",
      ),
            Product(
        id: 7,
        name: "Chicken Rolls",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 20,
        imageUrl: "assets/images/food_7.png",
        rating: 4.6,
        category: "Rolls",
      ),
         Product(
        id: 8,
        name: "Veg Rolls",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 15,
        imageUrl: "assets/images/food_8.png",
        rating: 4.0,
        category: "Rolls",
      ),
      //desserts
        Product(
        id: 9,
        name: "Ripple Ice Cream",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 14,
        imageUrl: "assets/images/food_9.png",
        rating: 4.4,
        category: "Desserts",
      ),
       Product(
        id: 10,
        name: "Fruit Ice Cream",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 22,
        imageUrl: "assets/images/food_10.png",
        rating: 4.6,
        category: "Desserts",
      ),
        Product(
        id: 11,
        name: "Jar Ice Cream",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 10,
        imageUrl: "assets/images/food_11.png",
        rating: 4.2,
        category: "Desserts",
      ),
       Product(
        id: 12,
        name: "Vanilla Ice Cream",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 12,
        imageUrl: "assets/images/food_12.png",
        rating: 4.3,
        category: "Desserts",
      ),
      //sandwich
        Product(
        id: 13,
        name: "Chicken Sandwich",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 12,
        imageUrl: "assets/images/food_13.png",
        rating: 4.4,
        category: "Sandwich",
      ),
       Product(
        id: 14,
        name: "Vegan Sandwich",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 18,
        imageUrl: "assets/images/food_14.png",
        rating: 4.1,
        category: "Sandwich",
      ),
        Product(
        id: 15,
        name: "Grilled Sandwich",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 16,
        imageUrl: "assets/images/food_15.png",
        rating: 4.5,
        category: "Sandwich",
      ),
           Product(
        id: 16,
        name: "Bread Sandwich",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 24,
        imageUrl: "assets/images/food_16.png",
        rating: 4.6,
        category: "Sandwich",
      ),
      //cake
       Product(
        id: 17,
        name: "Cup Cake",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 14,
        imageUrl: "assets/images/food_17.png",
        rating: 4.3,
        category: "Cake",
      ),
       Product(
        id: 18,
        name: "Vegan Cake",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 12,
        imageUrl: "assets/images/food_18.png",
        rating: 4.2,
        category: "Cake",
      ),
      Product(
        id: 19,
        name: "Butterscotch Cake",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 20,
        imageUrl: "assets/images/food_19.png",
        rating: 4.7,
        category: "Cake",
      ),
          Product(
        id: 20,
        name: "Sliced Cake",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 15,
        imageUrl: "assets/images/food_20.png",
        rating: 4.4,
        category: "Cake",
      ),
      //pure veg
      Product(
        id: 21,
        name: "Garlic Mushroom",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 14,
        imageUrl: "assets/images/food_21.png",
        rating: 4.3,
        category: "Pure Veg",
      ),
        Product(
        id: 22,
        name: "Fried Cauliflower",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 22,
        imageUrl: "assets/images/food_22.png",
        rating: 4.5,
        category: "Pure Veg",
      ),
      Product(
        id: 23,
        name: "Mix Veg Pulao",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 10,
        imageUrl: "assets/images/food_23.png",
        rating: 4.1,
        category: "Pure Veg",
      ),
         Product(
        id: 24,
        name: "Rice Zucchini",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 12,
        imageUrl: "assets/images/food_24.png",
        rating: 4.2,
        category: "Pure Veg",
      ),
    //pasta
      Product(
        id: 25,
        name: "Cheese Pasta",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 12,
        imageUrl: "assets/images/food_25.png",
        rating: 4.4,
        category: "Pasta",
      ),
       Product(
        id: 26,
        name: "Tomato Pasta",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 18,
        imageUrl: "assets/images/food_26.png",
        rating: 4.3,
        category: "Pasta",
      ),
      Product(
        id: 27,
        name: "Creamy Pasta",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 16,
        imageUrl: "assets/images/food_27.png",
        rating: 4.6,
        category: "Pasta",
      ),
       Product(
        id: 28,
        name: "Chicken Pasta",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 24,
        imageUrl: "assets/images/food_28.png",
        rating: 4.8,
        category: "Pasta",
      ),
      //noodles
       Product(
        id: 29,
        name: "Butter Noodles",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 14,
        imageUrl: "assets/images/food_29.png",
        rating: 4.4,
        category: "Noodles",
      ),
       Product(
        id: 30,
        name: "Veg Noodles",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 12,
        imageUrl: "assets/images/food_30.png",
        rating: 4.2,
        category: "Noodles",
      ),
      Product(
        id: 31,
        name: "Somen Noodles",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 20,
        imageUrl: "assets/images/food_31.png",
        rating: 4.5,
        category: "Noodles",
      ),
       Product(
        id: 32,
        name: "Cooked Noodles",
        description:
            "Food provides essential nutrients for overall health and well-being",
        price: 15,
        imageUrl: "assets/images/food_32.png",
        rating: 4.3,
        category: "Noodles",
      ),
    ];
  static List<Product> getProducts() {
  return List.unmodifiable(_products);
}
   static void updateProduct(Product updatedProduct) {
    final index =
        _products.indexWhere((p) => p.id == updatedProduct.id);

    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }
  static void deleteProduct(Product product) {
  _products.removeWhere((p) => p.id == product.id);
}

static void addProduct(Product product) {
  _products.add(product);
}

 
}