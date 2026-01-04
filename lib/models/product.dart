class Product {
  final int id;
  final String name; 
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;

  Product({
      required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.rating,
      required this.category,
  });

  factory Product.fromJson(Map<String,dynamic>json){
    return Product(id: json['id'],
    name:json ['name'],
    description: json['description'],
    price: json['price'].toDouble(),
    imageUrl: json['imageUrl'],
    rating: json['rating'].toDouble(),
    category: json['category'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'name':name,
      'description':description,
      'price':price,
      'imageUrl': imageUrl,
      'rating': rating,
      'category':category,
    };
  }
}
