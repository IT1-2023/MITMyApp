import 'package:flutter/material.dart';
import 'package:restaurant_app/services/product_service.dart';
import 'package:restaurant_app/widgets/banner_widget.dart';
import 'package:restaurant_app/widgets/footer_section.dart';
import 'package:restaurant_app/widgets/product_card.dart';

class HomeScreen extends StatelessWidget{
  final products = ProductService.getProducts();

  Widget build(BuildContext context){
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(children: [
          BannerWidget(),
          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,), 
            itemCount: products.length, itemBuilder: (context,index){
              return ProductCard(product: products [index]);
            },),
            const SizedBox(height: 30),
            const FooterSection(),
        ],),
      ),
    );
  }
}