import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget{
  const FooterSection({super.key});

@override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "RestaurantApp",
            style: TextStyle(color: Colors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text("Quality food delivered to your door.",
          style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _FooterColumn(title:"Company",
              items:["Home","About us", "Delivery", "Privacy policy"],
              ),
              _FooterColumn( title: "Get in touch",
              items:["+381 64 123 456", "contact@restaurantapp.com"],
              ),
            ],
            
          ),

        ],
      ),
    );
  }
}
class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterColumn({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              item,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ),
      ],
    );
  }
}
